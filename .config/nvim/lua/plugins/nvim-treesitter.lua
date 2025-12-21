-- :InspectTree
-- cargo install --locked tree-sitter-cli

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- main = "nvim-treesitter.configs",
  -- branch = "master",
  -- version = false,
  lazy = false,
  enabled = function() -- Disable in files with more than 5000 lines.
    return vim.api.nvim_buf_line_count(vim.api.nvim_get_current_buf()) <= 5000
  end,
  dependencies = {
    {
      "hiphish/rainbow-delimiters.nvim",
      config = function()
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
    { "windwp/nvim-ts-autotag", opts = {} },
  },
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "query",
      "python",
      "c",
      "cpp",
      "markdown",
      "markdown_inline",
      "csv",
      "json",
    },
    auto_install = true,
    highlight = { enable = true, disable = { "help" } },
  },
}
