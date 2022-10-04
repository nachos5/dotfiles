-- https://github.com/charmbracelet/glow

local Remap = require("keymap")
local nmap = Remap.nmap

require("glow").setup({
  style = "dark",
  width = 120,
})

local default_opts = { silent = true }

nmap("<leader>gl", "<cmd>Glow<CR>", default_opts)
