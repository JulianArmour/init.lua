return {
  'olimorris/codecompanion.nvim',
  opts = {
    adapters = {
      copilot = function ()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'gpt-4.1',
            }
          }
        })
      end,
    },
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          show_result_in_chat = true, -- Show mcp tool results in chat
          make_vars = true,         -- Convert resources to #variables
          make_slash_commands = true, -- Add prompts as /slash commands
        },
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim',
  },
}
