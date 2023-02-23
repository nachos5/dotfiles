local nnoremap = require("keymap").nnoremap

local shared_opts = { silent = true }

nnoremap("<leader>gd", ":Gvdiffsplit<CR>", shared_opts)
nnoremap("<leader>gm", ":Gvdiffsplit master<CR>", shared_opts)
nnoremap("<leader>gb", ":Git blame<CR>", shared_opts)
nnoremap("<leader>gs", ":vertical bo Git<CR>", shared_opts)
nnoremap("<leader>gr", ":GBrowse<CR>", shared_opts)

nnoremap("<leader>geh", ":Gedit<CR>", shared_opts)
nnoremap("<leader>ge1", ":Gedit HEAD~1:%<CR>", shared_opts)
nnoremap("<leader>ge2", ":Gedit HEAD~2:%<CR>", shared_opts)
nnoremap("<leader>ge3", ":Gedit HEAD~3:%<CR>", shared_opts)
nnoremap("<leader>ge4", ":Gedit HEAD~4:%<CR>", shared_opts)
nnoremap("<leader>ge5", ":Gedit HEAD~5:%<CR>", shared_opts)
nnoremap("<leader>ge6", ":Gedit HEAD~6:%<CR>", shared_opts)
nnoremap("<leader>ge7", ":Gedit HEAD~7:%<CR>", shared_opts)
nnoremap("<leader>ge8", ":Gedit HEAD~8:%<CR>", shared_opts)
nnoremap("<leader>ge9", ":Gedit HEAD~9:%<CR>", shared_opts)
