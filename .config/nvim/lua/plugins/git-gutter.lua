local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nmap("ðh", "<Plug>(GitGutterNextHunk)")
nmap("'h", "<Plug>(GitGutterPrevHunk)")
