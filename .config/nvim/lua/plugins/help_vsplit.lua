return {
  "anuvyklack/help-vsplit.nvim",
  event = "VeryLazy",
  config = function()
    require("help-vsplit").setup()
  end,
}
