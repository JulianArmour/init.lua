vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function() vim.diagnostic.jump{count=-1} end,
  { desc = "Go to previous diagnostic message" })
vim.keymap.set( 'n', ']d', function() vim.diagnostic.jump{count=1} end,
  { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
  { desc = "Open diagnostics list" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- more fluid window resizing
vim.keymap.set('n', '<M-k>', '<cmd>resize +1<CR>', { desc = "Increase window height" })
vim.keymap.set('n', '<M-j>', '<cmd>resize -1<CR>', { desc = "Decrease window height" })
vim.keymap.set('n', '<M-l>', '<cmd>vertical resize +1<CR>', { desc = "Increase window width" })
vim.keymap.set('n', '<M-h>', '<cmd>vertical resize -1<CR>', { desc = "Decrease window width" })

-- close help window
vim.keymap.set('n', '<C-w>H', '<cmd>helpclose<CR>', { desc = "Close help window" })

return {}
