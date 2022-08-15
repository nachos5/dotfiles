local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

inoremap("jk", "<Esc>")
vnoremap("<leader>jk", "<Esc>")
nnoremap("<leader>sv", ":source $MYVIMRC<CR>")
-- search for visually selected text
vnoremap("//", "y/<C-R>=escape(@\",'/')<CR><CR>")

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
nnoremap("<leader>t1", "1gt")
nnoremap("<leader>t2", "2gt")
nnoremap("<leader>t3", "3gt")
nnoremap("<leader>t4", "4gt")
nnoremap("<leader>t5", "5gt")
nnoremap("<leader>t6", "6gt")
nnoremap("<leader>t7", "7gt")
nnoremap("<leader>t8", "8gt")
nnoremap("<leader>t9", "9gt")
nnoremap("<leader>t0", "10gt")

-- view messages
nnoremap("<leader>m", ":messages<CR>")

-- buffers
nnoremap("<leader>c", ":bp<CR>")
nnoremap("<leader>v", ":bn<CR>")
nnoremap("<leader>d", ":bd<CR>")
