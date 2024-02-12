local nnoremap = require("keymap").nnoremap

local opts = { silent = true, noremap = true }

nnoremap("<leader>sqi", ":e" .. os.getenv("HOME") .. "/sql_format/initial.sql<CR>", opts)
nnoremap("<leader>sqo", ":e" .. os.getenv("HOME") .. "/sql_format/out.sql<CR>", opts)
nnoremap("<leader>sqp", ":e" .. os.getenv("HOME") .. "/sql_format/params.txt<CR>", opts)

nnoremap("<leader>sqr", ":!" .. os.getenv("HOME") .. "/sql_format/replace.sh<CR>", opts)
