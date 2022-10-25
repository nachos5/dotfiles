local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nnoremap("<leader>gd", ":Gdiffsplit<CR>")
nnoremap("<leader>gb", ":Git blame<CR>")
nnoremap("<leader>geh", ":Gedit")
nnoremap("<leader>ge1", ":Gedit HEAD~1:%")
nnoremap("<leader>ge2", ":Gedit HEAD~2:%")
nnoremap("<leader>ge3", ":Gedit HEAD~3:%")
nnoremap("<leader>ge4", ":Gedit HEAD~4:%")
nnoremap("<leader>ge5", ":Gedit HEAD~5:%")
nnoremap("<leader>ge6", ":Gedit HEAD~6:%")
nnoremap("<leader>ge7", ":Gedit HEAD~7:%")
nnoremap("<leader>ge8", ":Gedit HEAD~8:%")
nnoremap("<leader>ge9", ":Gedit HEAD~9:%")
