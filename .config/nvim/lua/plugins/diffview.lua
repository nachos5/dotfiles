local nnoremap = require("keymap").nnoremap

nnoremap("<leader>vo", ":DiffviewOpen<CR>", { silent = true })
nnoremap("<leader>vc", ":DiffviewClose<CR>", { silent = true })
nnoremap("<leader>vh", ":DiffviewFileHistory %<CR>", { silent = true })
nnoremap("<leader>vm", ":DiffviewOpen master...HEAD<CR>", { silent = true })
