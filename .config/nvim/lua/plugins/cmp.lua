return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "quangnguyen30192/cmp-nvim-tags",
    "saadparwaiz1/cmp_luasnip",
    "ray-x/cmp-treesitter",
    "David-Kunz/cmp-npm",
    -- vscode-like pictograms for neovim lsp completion items
    "onsails/lspkind-nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    vim.o.completeopt = "menuone,noselect,preview"
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.shortmess:append("c")
    cmp.setup({
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
        { name = "buffer", priority = 7, keyword_length = 5 },
        { name = "nvim_lua", priority = 5 },
        { name = "path", priority = 4 },
        { name = "calc", priority = 3 },
        { name = "treesitter" },
        { name = "nvim_lsp_signature_help" },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        expandable_indicator = true,
        format = function(entry, vim_item)
          -- icons
          local import_lspkind, lspkind = pcall(require, "lspkind")
          if import_lspkind then
            vim_item.kind = lspkind.presets.default[vim_item.kind] or vim_item.kind
          end

          -- limit completion width
          local ELLIPSIS_CHAR = "…"
          local MAX_LABEL_WIDTH = 35
          local label = vim_item.abbr or "[Src]"
          local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
          if truncated_label ~= label then
            vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
          end

          -- set a name for each source
          vim_item.menu = ({
            buffer = "[Buff]",
            copilot = "[Copilot]",
            latex_symbols = "[Latex]",
            luasnip = "[LuaSnip]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
          })[entry.source.name]

          return vim_item
        end,
      },
      view = {
        entries = "native",
      },
    })

    require("cmp-npm").setup({
      ignore = {},
      only_semantic_versions = true,
    })

    -- Setup vim-dadbod
    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
  end,
}
