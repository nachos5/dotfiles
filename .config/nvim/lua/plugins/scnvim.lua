local scnvim = require("scnvim")
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup({
  keymaps = {
    ["<leader>li"] = map("editor.send_line", { "i", "n" }),
    ["<C-e>"] = {
      map("editor.send_block", { "i", "n" }),
      map("editor.send_selection", "x"),
    },
    ["<CR>"] = map("postwin.toggle"),
    ["<M-CR>"] = map("postwin.toggle", "i"),
    ["<leader>cl"] = map("postwin.clear", { "n", "i" }),
    ["<leader>si"] = map("signature.show", { "n", "i" }),
    ["<leader>q"] = map("sclang.hard_stop", { "n", "x", "i" }),
    ["<leader>st"] = map("sclang.start"),
    ["<leader>sk"] = map("sclang.recompile"),
    ["<leader>sp"] = map_expr("Server.local.plotTree", { "n", "x" }),
    ["<leader>sm"] = map_expr("Server.local.meter", { "n", "x" }),
    ["<leader>sb"] = map_expr("s.boot"),
    ["<leader>sq"] = map_expr("s.quit"),
    ["<leader>rt"] = map(function()
      vim.cmd("SCNvimGenerateAssets")
    end, { "n", "x", "i" }),
    ["<leader>+"] = map_expr("s.volume = s.volume.volume + 5"),
    ["<leader>-"] = map_expr("s.volume = s.volume.volume - 5"),
    -- FzfSC
    ["<F1>"] = scnvim.map(function()
      vim.cmd("FzfSC")
    end, { "n", "x", "i" }),
    -- h4x
    ["<F2>"] = scnvim.map(function()
      vim.cmd("SCExternalHelpSearch")
      -- vim.cmd("!brave file:///home/mads/.local/share/SuperCollider/Help/Help.html")
    end, { "n", "x", "i" }),
  },
  editor = {
    highlight = {
      color = "IncSearch",
      type = "flash",
    },
  },
  documentation = {
    cmd = "/bin/pandoc",
  },
  postwin = {
    float = {
      enabled = true,
      height = 24,
      width = function()
        return math.floor(vim.fn.winwidth(0) / 2)
      end,
    },
  },
  snippet = {
    engine = {
      name = "luasnip",
    },
  },
  extensions = {
    tmux = {
      path = vim.fn.tempname(),
      horizontal = true,
      size = "35%",
      cmd = "tail",
      args = { "-F", "$1" },
    },
    logger = {
      path = "/tmp/scnvim-logs.txt",
    },
  },
})

-- scnvim.load_extension('logger')
scnvim.load_extension("tmux")
scnvim.load_extension("piano")
scnvim.load_extension("fzf-sc")

require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
