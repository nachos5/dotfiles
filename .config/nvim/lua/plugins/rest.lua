local nnoremap = require("keymap").nnoremap

require("rest-nvim").setup()

local shared_opts = { silent = true }

nnoremap("<leader>rn", "<Plug>RestNvim", shared_opts)
nnoremap("<leader>rm", "<Plug>RestNvimPreview", shared_opts)
