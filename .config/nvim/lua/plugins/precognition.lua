local nnoremap = require("keymap").nnoremap

nnoremap("<leader>pc", require("precognition").toggle, { silent = true })
