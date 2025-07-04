return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    {'echasnovski/mini.icons', opts = {}, version = false},
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- code = {
    -- },
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
