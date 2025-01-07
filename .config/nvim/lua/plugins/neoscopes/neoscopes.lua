return {
  "smartpde/neoscopes",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = function()
    local scopes = require("neoscopes")
    local utils = require("plugins/neoscopes/utils")
    return {
      { "<leader>ss", scopes.select },
      { "<leader>si", utils.toggle_ignore_scopes },
    }
  end,
}
