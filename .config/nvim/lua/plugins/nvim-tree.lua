local nnoremap = require("keymap").nnoremap

require("nvim-tree").setup({
  git = {
    ignore = false,
  },
  view = {
    relativenumber = true,
  },
})

nnoremap("<C-n>", ":NvimTreeToggle<CR>")
nnoremap("<leader>n", ":NvimTreeFindFile<CR>")
nnoremap("<leader>tc", ":NvimTreeCollapse<CR>")
nnoremap("<leader>tr", ":NvimTreeRefresh<CR>")

--- More available functions:
--- NvimTreeOpen
--- NvimTreeClose
--- NvimTreeFocus
--- NvimTreeFindFileToggle
--- NvimTreeResize
--- NvimTreeCollapse
--- NvimTreeCollapseKeepBuffers
