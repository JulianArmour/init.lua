return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    {'echasnovski/mini.icons', opts = {}, version = false},
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'codecompanion'},
    overrides = {
      buftype = {
        nofile = {
          code = {
            style = "normal",
          },
          -- sign = { enabled = false },
        },
      },
    }
  },
}
