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

require('vim.treesitter.query').set('python', 'injections', [[
(call
  function: (identifier) @_function (#eq? @_function "SQL")

  (argument_list

  (string) @sql))
]])
