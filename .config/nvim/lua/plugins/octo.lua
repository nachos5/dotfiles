local nnoremap = require("keymap").nnoremap

-- https://github.com/pwntester/octo.nvim#-pr-review

require("octo").setup()

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>op", ":Octo pr list<CR>", default_opts)
nnoremap("<leader>oa", ":Octo actions<CR>", default_opts)
