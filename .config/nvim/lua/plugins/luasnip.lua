package.loaded["luasnip"] = nil
local ls = require("luasnip")
vim.cmd([[
nnoremap <silent><leader>rs :lua package.loaded["plugins/luasnip"]=nil; require"plugins/luasnip"; print("Resourced luasnip snippety snipz :)))")<cr>
imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]])
-- local t = function(str)
-- 	return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
-- Every unspecified option will be set to the default.
ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
  -- ext_opts = {
  -- 	[types.choiceNode] = {
  -- 		active = {
  -- 			virt_text = { { "choiceNode", "Comment" } },
  -- 		},
  -- 	},
  -- },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true,
})
ls.filetype_set("vimwiki", { "markdown" })
-- ls.filetype_set("scdoc", { "supercollider" })
require("luasnip/loaders/from_vscode").load()
-- Make luasnip edit command
vim.cmd([[
command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()
]])

-- Load all snippets
require("luasnip.loaders.from_lua").load({ paths = "~/utils/nvim/lua/snippets" })
