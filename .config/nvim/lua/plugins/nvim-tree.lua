return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  version = "nightly", -- optional, updated every week. (see issue #1193)
  keys = {
    { "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    { "<leader>n", ":NvimTreeFindFile<CR>", desc = "Find file in NvimTree" },
    { "<leader>tc", ":NvimTreeCollapse<CR>", desc = "Collapse NvimTree" },
    { "<leader>tr", ":NvimTreeRefresh<CR>", desc = "Refresh NvimTree" },
  },
  config = function()
    require("nvim-tree").setup({
      git = {
        ignore = false,
      },
      view = {
        relativenumber = true,
      },
    })
  end,
}
