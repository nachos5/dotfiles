-- :InspectTree

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
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
        autotag = {
          enable = true,
        },
      })

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

      require("vim.treesitter.query").set(
        "python",
        "injections",
        [[
      (call
        function: (identifier) @_function (#eq? @_function "SQL")

        (argument_list

        (string) @sql))
      ]]
      )
    end,
  },

  -- Automatically add closing tags for HTML and JSX.
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
}
