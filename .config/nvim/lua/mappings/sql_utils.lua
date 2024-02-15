local nnoremap = require("keymap").nnoremap

local opts = { silent = true, noremap = true }

nnoremap("<leader>sqi", ":e" .. vim.g.OS_HOME .. "/sql_format/initial.sql<CR>", opts)
nnoremap("<leader>sqo", ":e" .. vim.g.OS_HOME .. "/sql_format/out.sql<CR>", opts)
nnoremap("<leader>sqp", ":e" .. vim.g.OS_HOME .. "/sql_format/params.txt<CR>", opts)

nnoremap("<leader>sqr", ":!" .. vim.g.OS_HOME .. "/sql_format/replace.sh<CR>", opts)
