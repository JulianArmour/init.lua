local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  -- if client.name == "clangd" then
  --   client.server_capabilities.semanticTokensProvider = nil
  -- end

  --highlight symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup('lsp_document_highlight', {
      clear = false,
    })
    vim.api.nvim_create_autocmd('CursorHold', {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd('LspDetach', {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_del_augroup_by_id(group)
      end,
    })
  end
end

local find_work_clangd = function()
  local command_files = vim.fs.find(function(name)
    return name:match('%.command$') ~= nil
  end, {
    path = vim.fn.getcwd(),
    type = 'file',
    limit = 1,
  })

  local command_file = command_files[1]
  if not command_file then
    return nil
  end

  local lines = vim.fn.readfile(command_file)
  local contents = table.concat(lines, '\n')
  local toolchain_dir = contents:match('(/auto/binos%-tools/llvm%d+/llvm%-%S+)/bin/[%w._+-]+')
  if not toolchain_dir then
    return nil
  end

  return toolchain_dir .. '/bin/clangd'
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim',          opts = {}, },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'j-hui/fidget.nvim',                opts = {}, },
    { 'hrsh7th/cmp-nvim-lsp' },
  },
  config = function()
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- local servers = { 'lua_ls', 'gopls', 'pyright', }

    vim.lsp.config('*', {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.config('gopls', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          buildFlags = {"-tags=systest"},
        },
      }
    })
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })
    vim.lsp.config('pyright', {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(_, on_dir)
        on_dir(vim.fn.getcwd())
      end,
    })
    if vim.g.at_work then
      local clangd_cmd = find_work_clangd() or '/auto/binos-tools/llvm14/llvm-14.0-p47/bin/clangd'
      vim.lsp.config('clangd', {
        cmd = {
          clangd_cmd,
          '--header-insertion=never',
          '--clang-tidy',
          '--background-index',
          '--limit-results=30',
          '--pch-storage=memory',
          '--log=error',
          '-j=4',
        },
        capabilities = vim.tbl_deep_extend('force', capabilities, {
          offsetEncoding = 'utf-16',
        }),
        -- debounce_text_changes = 1000,
        on_attach = on_attach,
      })
    end

    require 'mason-lspconfig'.setup {
      ensure_installed = {},
      automatic_enable = true,
    }
  end
}
