local nnoremap = require("keymap").nnoremap

local opts = { silent = true, noremap = true }

local luafile = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "lua_file.lua"

-- Edit the lua file.
nnoremap("<leader>lue", ":e" .. luafile .. "<CR>", opts)

-- Run the lua file.
nnoremap("<leader>lur", ":luafile " .. luafile .. "<CR>", opts)
