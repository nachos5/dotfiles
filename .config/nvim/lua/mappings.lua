local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
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
nnoremap("<C-A-down>", ":m .+1<CR>==", { silent = true })
nnoremap("<C-A-up>", ":m .-2<CR>==", { silent = true })
inoremap("<C-A-down>", "<Esc>:m .+1<CR>==gi", { silent = true })
inoremap("<C-A-up>", "<Esc>:m .-2<CR>==gi", { silent = true })
vnoremap("<C-A-down>", ":m '>+1<CR>gv=gv", { silent = true })
vnoremap("<C-A-up>", ":m '<-2<CR>gv=gv", { silent = true })

-- move between panes to left/bottom/top/right")
nnoremap("<C-h>", "<C-w>h", { silent = true })
nnoremap("<C-j>", "<C-w>j", { silent = true })
nnoremap("<C-k>", "<C-w>k", { silent = true })
nnoremap("<C-l>", "<C-w>l", { silent = true })
nnoremap("<C-left>", "<C-w>h", { silent = true })
nnoremap("<C-down>", "<C-w>j", { silent = true })
nnoremap("<C-up>", "<C-w>k", { silent = true })
nnoremap("<C-right>", "<C-w>l", { silent = true })

-- escape terminal
vim.cmd([[
tnoremap <leader>jk <C-\><C-n>
tnoremap <leader><Esc> <C-\><C-n>
]])

-- view messages
nnoremap("<leader>me", ":messages<CR>", { silent = true })

-- buffers
nnoremap("<leader>bp", ":bp<CR>", { silent = true })
nnoremap("<leader>bn", ":bn<CR>", { silent = true })
function remove_current_buffer()
  MiniBufremove.delete(0, false)
end
nnoremap("<leader>d", ":lua remove_current_buffer()<CR>", { silent = true })
function remove_all_buffers()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    MiniBufremove.delete(buffer, false)
  end
end
nnoremap("<leader>bd", ":lua remove_all_buffers()<CR>", { silent = true })
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
nnoremap("<S-Up>", ":lua resize_current_window(2, false)<CR>", { silent = true })
nnoremap("<S-Down>", ":lua resize_current_window(-2, false)<CR>", { silent = true })
nnoremap("<S-Left>", ":lua resize_current_window(-5, true)<CR>", { silent = true })
nnoremap("<S-Right>", ":lua resize_current_window(5, true)<CR>", { silent = true })
-- resize in terminal mode
vim.cmd([[
tnoremap <S-Up> <C-\><C-n> :lua resize_current_window(2, false)<CR> i
tnoremap <S-Down> <C-\><C-n> :lua resize_current_window(-2, false)<CR> i
]])

-- quickfix list
nnoremap("<leader>qo", ":copen<CR>", { silent = true })
nnoremap("<leader>qc", ":cclose<CR>", { silent = true })
nnoremap("<leader>qn", ":cnext<CR>", { silent = true })
nnoremap("<leader>qp", ":cprev<CR>", { silent = true })
-- location list
nnoremap("<leader>lo", ":lopen<CR>", { silent = true })
nnoremap("<leader>lc", ":lclose<CR>", { silent = true })
nnoremap("<leader>ln", ":lnext<CR>", { silent = true })
nnoremap("<leader>lp", ":lprev<CR>", { silent = true })
