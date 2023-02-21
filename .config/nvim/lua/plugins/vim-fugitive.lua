local nnoremap = require("keymap").nnoremap

nnoremap("<leader>gd", ":Gdiffsplit<CR>")
nnoremap("<leader>gm", ":vertical bo Gdiffsplit master<CR>")
nnoremap("<leader>gb", ":Git blame<CR>")
nnoremap("<leader>gs", ":vertical bo Git<CR>")
nnoremap("<leader>gc", ":Git commit<CR>")
nnoremap("<leader>gp", ":Git push<CR>")
nnoremap("<leader>gl", ":vsp | GcLog<CR>")
-- TODO GBrowse

nnoremap("<leader>geh", ":Gedit<CR>")
nnoremap("<leader>ge1", ":Gedit HEAD~1:%<CR>")
nnoremap("<leader>ge2", ":Gedit HEAD~2:%<CR>")
nnoremap("<leader>ge3", ":Gedit HEAD~3:%<CR>")
nnoremap("<leader>ge4", ":Gedit HEAD~4:%<CR>")
nnoremap("<leader>ge5", ":Gedit HEAD~5:%<CR>")
nnoremap("<leader>ge6", ":Gedit HEAD~6:%<CR>")
nnoremap("<leader>ge7", ":Gedit HEAD~7:%<CR>")
nnoremap("<leader>ge8", ":Gedit HEAD~8:%<CR>")
nnoremap("<leader>ge9", ":Gedit HEAD~9:%<CR>")
