local env_config = require("env").config

-- @codebase
return {
  "yetone/avante.nvim",
  -- event = "VeryLazy",
  opts = {
    -- export ANTHROPIC_API_KEY=your-api-key
    provider = env_config.LLM_PROVIDER and env_config.LLM_PROVIDER or "claude",
    auto_suggestions_provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = require("env").config.CLAUDE_OLDER_MODEL and "claude-3-5-sonnet-20241022" or "claude-3-7-sonnet-20250219",
      temperature = 0,
      max_tokens = 4096,
      disable_tools = {
        "rag_search",
        "python",
        "git_diff",
        "git_commit",
        "list_files",
        "search_files",
        "search_keyword",
        -- "read_file_toplevel_symbols",
        -- "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",
        "web_search",
        -- "fetch",
        "str_replace",
        "str_replace_editor",
      },
    },
    ollama = {
      model = "deepseek-r1:7b",
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = false,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
    },
    hints = { enabled = false },
  },
  version = false, -- set this if you want to always pull the latest change
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    -- "stevearc/dressing.nvim",
    -- "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>AvanteToggle<CR>" },
    { "<leader>ad", "<cmd>AvanteClear<CR>" },
    { "<leader>an", "<cmd>AvanteChatNew<CR>" },
  },
}
