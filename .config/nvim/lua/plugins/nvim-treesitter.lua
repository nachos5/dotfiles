-- :InspectTree

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- branch = "main",
    lazy = false,
    enabled = function() -- Disable in files with more than 5000 lines.
      return vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf()) <= 5000
    end,
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
    },
    config = function()
      -- Tree-sitter configuration
      require("nvim-treesitter.configs").setup({
        -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
        highlight = {
          enable = true,
          disable = { "help" },
        },
      })
      require("nvim-ts-autotag").setup()

      -- This module contains a number of default definitions
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Automatically add closing tags for HTML and JSX.
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
}
