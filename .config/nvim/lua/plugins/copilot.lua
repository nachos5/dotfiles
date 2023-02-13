local nnoremap = require("keymap").nnoremap

require("copilot").setup()

local default_opts = { silent = true }

nnoremap("<leader>pa", ":Copilot auth<CR>", default_opts)
nnoremap("<leader>pp", ":Copilot panel<CR>", default_opts)
nnoremap("<leader>pr", function()
  require("copilot.panel").refresh()
end, default_opts)
