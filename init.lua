vim.g.at_work = false
if string.match(vim.fn.hostname(), '%l+-ads%-%d+') ~= nil then
  vim.g.at_work = true
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('options')
require('keymaps')
require('autocmds')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'custom.plugins' },
  { import = 'plugins' }
})

-- vim: ts=2 sts=2 sw=2 et
