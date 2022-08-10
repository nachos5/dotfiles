local ls = require("luasnip")

-- Every unspecified option will be set to the default.
ls.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
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

vim.cmd([[
imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]])
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
