local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

inoremap("jk", "<Esc>")
nnoremap("<leader>sv", ":source $MYVIMRC<CR>")

-- move line
nnoremap("<C-A-j>", ":m .+1<CR>==")
nnoremap("<C-A-k>", ":m .-2<CR>==")
inoremap("<C-A-j>", "<Esc>:m .+1<CR>==gi")
inoremap("<C-A-k>", "<Esc>:m .-2<CR>==gi")
vnoremap("<C-A-j>", ":m '>+1<CR>gv=gv")
vnoremap("<C-A-k>", ":m '<-2<CR>gv=gv")

-- move split panes to left/bottom/top/right - todo?
-- nnoremap("<C-A-h>", "<C-W>H")
-- nnoremap("<C-A-j>", "<C-W>J")
-- nnoremap("<C-A-k>", "<C-W>K")
-- nnoremap("<C-A-l>", "<C-W>L")

-- move between panes to left/bottom/top/right")
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- escape terminal
vim.cmd([[
tnoremap <leader><Esc> <C-\><C-n>
]])

-- vim tabs
nnoremap("<leader>tc", ":tabclose<CR>")
nnoremap("<leader>tn", ":tabnew<CR>")
nnoremap("<leader>to", ":tabonly<cr>")
nnoremap("<leader>tm", ":tabmove<Space>")
nnoremap("<leader>1", "1gt")
nnoremap("<leader>2", "2gt")
nnoremap("<leader>3", "3gt")
nnoremap("<leader>4", "4gt")
nnoremap("<leader>5", "5gt")
nnoremap("<leader>6", "6gt")
nnoremap("<leader>7", "7gt")
nnoremap("<leader>8", "8gt")
nnoremap("<leader>9", "9gt")
nnoremap("<leader>0", "10gt")

-- view messages
nnoremap("<leader>m", ":messages<CR>")
