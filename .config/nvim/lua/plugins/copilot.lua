local nnoremap = require("keymap").nnoremap

vim.cmd([[
imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
]])

nnoremap("<leader>pa", ":Copilot panel<CR>", default_opts)
