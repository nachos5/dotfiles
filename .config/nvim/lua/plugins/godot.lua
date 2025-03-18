return {
  "lommix/godot.nvim",
  event = "VeryLazy",
  config = function()
    local godot = require("godot")
    godot.setup({
      bin = "godot",
    })
  end,
}
