-- https://github.com/charmbracelet/glow

local nnoremap = require("keymap").nnoremap

require("glow").setup({
  style = "dark",
  width = 120,
})

local default_opts = { silent = true }

nnoremap("<leader>gl", "<cmd>Glow<CR>", default_opts)
