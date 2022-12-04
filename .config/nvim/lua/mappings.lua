local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local nmap = Remap.nmap

inoremap("jk", "<Esc>", { silent = true })
inoremap("JK", "<Esc>", { silent = true })
vnoremap("<leader>jk", "<Esc>", { silent = true })
vnoremap("<leader>JK", "<Esc>", { silent = true })
nnoremap("<leader>sv", ":source $MYVIMRC<CR>", { silent = true })
-- search for visually selected text
vnoremap("//", "y/<C-R>=escape(@\",'/')<CR><CR>", { silent = true })

-- move line
nnoremap("<C-A-j>", ":m .+1<CR>==", { silent = true })
nnoremap("<C-A-k>", ":m .-2<CR>==", { silent = true })
inoremap("<C-A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
inoremap("<C-A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
vnoremap("<C-A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vnoremap("<C-A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- move split panes to left/bottom/top/right - todo?
-- nnoremap("<C-A-h>", "<C-W>H")
-- nnoremap("<C-A-j>", "<C-W>J")
-- nnoremap("<C-A-k>", "<C-W>K")
-- nnoremap("<C-A-l>", "<C-W>L")

-- move between panes to left/bottom/top/right")
nnoremap("<C-h>", "<C-w>h", { silent = true })
nnoremap("<C-j>", "<C-w>j", { silent = true })
nnoremap("<C-k>", "<C-w>k", { silent = true })
nnoremap("<C-l>", "<C-w>l", { silent = true })

-- escape terminal
vim.cmd([[
tnoremap <leader>jk <C-\><C-n>
]])

-- vim tabs
-- nnoremap("<leader>tc", ":tabclose<CR>")
-- nnoremap("<leader>tn", ":tabnew<CR>")
-- nnoremap("<leader>to", ":tabonly<cr>")
-- nnoremap("<leader>tm", ":tabmove<Space>")
-- nnoremap("<leader>t1", "1gt")
-- nnoremap("<leader>t2", "2gt")
-- nnoremap("<leader>t3", "3gt")
-- nnoremap("<leader>t4", "4gt")
-- nnoremap("<leader>t5", "5gt")
-- nnoremap("<leader>t6", "6gt")
-- nnoremap("<leader>t7", "7gt")
-- nnoremap("<leader>t8", "8gt")
-- nnoremap("<leader>t9", "9gt")
-- nnoremap("<leader>t0", "10gt")

-- view messages
nnoremap("<leader>me", ":messages<CR>", { silent = true })

-- buffers
nnoremap("<leader>c", ":bp<CR>", { silent = true })
nnoremap("<leader>v", ":bn<CR>", { silent = true })
nnoremap("<leader>d", ":Bdelete<CR>", { silent = true })
nnoremap("<leader>bd", ":%bd<CR>", { silent = true })
nnoremap("<leader>br", ":edit!<CR>", { silent = true })

-- resize current window
function resize_current_window(amount, is_width)
  if not is_width then
    current_height = vim.api.nvim_win_get_height(0)
    set_height = math.max(0, current_height + amount)
    vim.api.nvim_win_set_height(0, set_height)
  else
    current_width = vim.api.nvim_win_get_width(0)
    set_width = math.max(0, current_width + amount)
    vim.api.nvim_win_set_width(0, set_width)
  end
end
-- resize in normal mode
nnoremap("<C-Up>", ":lua resize_current_window(2, false)<CR>", { silent = true })
nnoremap("<C-Down>", ":lua resize_current_window(-2, false)<CR>", { silent = true })
nnoremap("<C-Left>", ":lua resize_current_window(-5, true)<CR>", { silent = true })
nnoremap("<C-Right>", ":lua resize_current_window(5, true)<CR>", { silent = true })
-- resize in terminal mode
vim.cmd([[
tnoremap <C-Up> <C-\><C-n> :lua resize_current_window(2, false)<CR> i
tnoremap <C-Down> <C-\><C-n> :lua resize_current_window(-2, false)<CR> i
]])

-- quickfix list
nnoremap("<leader>qo", ":copen<CR>", { silent = true })
nnoremap("<leader>qc", ":cclose<CR>", { silent = true })
-- location list
nnoremap("<leader>lo", ":lopen<CR>", { silent = true })
nnoremap("<leader>lc", ":lclose<CR>", { silent = true })
