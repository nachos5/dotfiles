local Remap = require("keymap")
local nnoremap = Remap.nnoremap

require("mind").setup()

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>mm", "<cmd>MindOpenMain<CR>", default_opts)
nnoremap("<leader>mp", "<cmd>MindOpenProject<CR>", default_opts)
nnoremap("<leader>mc", "<cmd>MindClose<CR>", default_opts)

-- -- default keymaps; see 'mind.commands' for a list of commands that can be mapped to keys here
-- keymaps = {
--   -- keybindings when navigating the tree normally
--   normal = {
--     ["<cr>"] = "open_data",
--     ["<s-cr>"] = "open_data_index",
--     ["<tab>"] = "toggle_node",
--     ["<s-tab>"] = "toggle_parent",
--     ["/"] = "select_path",
--     ["$"] = "change_icon_menu",
--     c = "add_inside_end_index",
--     I = "add_inside_start",
--     i = "add_inside_end",
--     l = "copy_node_link",
--     L = "copy_node_link_index",
--     d = "delete",
--     O = "add_above",
--     o = "add_below",
--     q = "quit",
--     r = "rename",
--     R = "change_icon",
--     u = "make_url",
--     x = "select",
--   },
--
--   -- keybindings when a node is selected
--   selection = {
--     ["<cr>"] = "open_data",
--     ["<tab>"] = "toggle_node",
--     ["<s-tab>"] = "toggle_parent",
--     ["/"] = "select_path",
--     I = "move_inside_start",
--     i = "move_inside_end",
--     O = "move_above",
--     o = "move_below",
--     q = "quit",
--     x = "select",
--   },
-- }
