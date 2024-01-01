local nnoremap = require("keymap").nnoremap

vim.cmd([[
imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
]])

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>pa", ":Copilot panel<CR>", default_opts)
nnoremap("<leader>pd", ":Copilot disable<CR>", default_opts)
nnoremap("<leader>pe", ":Copilot enable<CR>", default_opts)
