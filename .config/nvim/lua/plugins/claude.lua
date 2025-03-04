return {
  -- requires elinks + pynvim
  "pasky/claude.vim",
  event = "VeryLazy",
  config = function()
    -- <leader>cc - ClaudeChat
    -- <leader>cx - ClaudeCancel
    -- visual <leader>ci - ClaudeImplement

    vim.g.claude_api_key = require("env").config.CLAUDE_API_KEY
  end,
}
