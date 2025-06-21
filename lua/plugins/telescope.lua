return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  opts = {
    {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        }
      },
    }
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension('ui-select')
    pcall(telescope.load_extension, 'fzf')
  end,
  keys = {
    { '<leader>?',       require('telescope.builtin').oldfiles, desc = '[?] Find recently opened files' },
    { '<leader><space>', require('telescope.builtin').buffers,  desc = '[ ] Find existing buffers' },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer'
    },
    { '<leader>gf', require('telescope.builtin').git_files,   desc = 'Search [G]it [F]iles' },
    { '<leader>sf', require('telescope.builtin').find_files,  desc = '[S]earch [F]iles' },
    { '<leader>sh', require('telescope.builtin').help_tags,   desc = '[S]earch [H]elp' },
    { '<leader>sw', require('telescope.builtin').grep_string, desc = '[S]earch current [W]ord' },
    { '<leader>sg', require('telescope.builtin').live_grep,   desc = '[S]earch by [G]rep' },
    { '<leader>sd', require('telescope.builtin').diagnostics, desc = '[S]earch [D]iagnostics' },
    { '<leader>tr', require('telescope.builtin').resume,      desc = '[T]elescope [R]esume' },
  },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    }
  }
}
