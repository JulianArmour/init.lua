return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle code outline" },
  },
  opts = {
    symbols = {
      filter = { "Variable", exclude = true }
    }
  },
}
