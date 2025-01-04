-- :Orphans
return {
  "ZWindL/orphans.nvim",
  event = "VeryLazy",
  config = function()
    require("orphans").setup({})
  end,
}
