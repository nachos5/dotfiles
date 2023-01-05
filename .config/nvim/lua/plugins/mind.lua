local Remap = require("keymap")
local nnoremap = Remap.nnoremap

require("mind").setup()

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>mm", "<cmd>MindOpenMain<CR>", default_opts)
nnoremap("<leader>mp", "<cmd>MindOpenSmartProject<CR>", default_opts)
nnoremap("<leader>mc", "<cmd>MindClose<CR>", default_opts)

-- mind-config-keymaps help tag to see default keymaps
