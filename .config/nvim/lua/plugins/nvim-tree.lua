local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

require("nvim-tree").setup()

nnoremap("<C-n>", ":NvimTreeToggle<CR>")
nnoremap("<leader>r", ":NvimTreeRefresh<CR>")
nnoremap("<leader>n", ":NvimTreeFindFile<CR>")
--- More available functions:
--- NvimTreeOpen
--- NvimTreeClose
--- NvimTreeFocus
--- NvimTreeFindFileToggle
--- NvimTreeResize
--- NvimTreeCollapse
--- NvimTreeCollapseKeepBuffers
