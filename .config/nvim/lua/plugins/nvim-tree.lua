local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

require("nvim-tree").setup({
  git = {
    ignore = false,
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
