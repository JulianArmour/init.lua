-- highlight what I yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--[[ -- open help window vertically to the right.
local help_group = vim.api.nvim_create_augroup('HelpWindow', {})
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(ev)
    local buffer_type = vim.api.nvim_get_option_value('buftype', {buf = ev.buf})
    if buffer_type == "help" then
      vim.cmd('wincmd L')
    end
  end,
  group = help_group,
  pattern = '*.txt',
}) ]]
