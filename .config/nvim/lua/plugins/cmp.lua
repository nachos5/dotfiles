-- https://codeberg.org/madskjeldgaard/dotfiles/src/branch/main/nvim/lua/plugins/cmp.lua

-- Setup nvim-cmp.
local cmp = require("cmp")
-- local lspkind = require "lspkind"
-- lspkind.init()
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "path" },
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lsp" },
    { name = "tags" },
    -- { name = 'nvim_lua' },
    { name = "treesitter" },
    -- { name = 'spell' },
    { name = "buffer", keyword_length = 5 }, -- dont complete until at 5 chars
  },
  formatting = {
    -- set up nice formatting for your sources.
    -- format = lspkind.cmp_format {
    -- 	with_text = true,
    -- 	menu = {
    -- 		nvim_lsp = "[LSP]",
    -- 		nvim_lua = "[api]",
    -- 		path = "[path]",
    -- 		luasnip = "[snip]",
    -- 		-- gh_issues = "[issues]",
    -- 		rg = "[ripgrep]",
    -- 		tags = "[tags]",
    -- 		buffer = "[buf]",
    -- 	},
    -- },
  },
  view = {
    entries = "native",
  },
  experimental = {
    -- native_menu = true,
    ghost_text = true,
  },
})
