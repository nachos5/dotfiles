local nnoremap = require("keymap").nnoremap

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>ghr", ":OpenInGHRepo<CR>", default_opts)
nnoremap("<leader>ghf", ":OpenInGHFile<CR>", default_opts)
