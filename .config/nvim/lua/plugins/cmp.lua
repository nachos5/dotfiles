-- https://codeberg.org/madskjeldgaard/dotfiles/src/branch/main/nvim/lua/plugins/cmp.lua

local cmp = require("cmp")
local luasnip = require("luasnip")

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "copilot", priority = 10 },
    { name = "luasnip", priority = 10 },
    { name = "nvim_lsp", priority = 9 },
    { name = "npm", priority = 9 },
    { name = "cmp_tabnine", priority = 8, max_num_results = 3 },
    { name = "buffer", priority = 7, keyword_length = 5, option = buffer_option },
    { name = "nvim_lua", priority = 5 },
    { name = "path", priority = 4 },
    { name = "calc", priority = 3 },
    { name = "treesitter" },
    { name = "nvim_lsp_signature_help" },
  },
  formatting = {
    format = function(entry, vim_item)
      -- icons
      local import_lspkind, lspkind = pcall(require, "lspkind")
      if import_lspkind then
        vim_item.kind = lspkind.presets.default[vim_item.kind]
      end

      -- limit completion width
      local ELLIPSIS_CHAR = "…"
      local MAX_LABEL_WIDTH = 35
      local label = vim_item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
      if truncated_label ~= label then
        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
      end

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buff]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
  view = {
    entries = "native",
  },
  experimental = {
    -- native_menu = true,
    ghost_text = true,
  },
})

require("cmp-npm").setup({
  ignore = {},
  only_semantic_versions = true,
})
