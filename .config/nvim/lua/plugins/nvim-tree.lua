return {
  "nvim-tree/nvim-tree.lua",
  -- Optional, updated every week.
  version = "nightly",
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
