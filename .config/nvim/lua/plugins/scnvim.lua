return {
  "davidgranstrom/scnvim",
  ft = "supercollider",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "davidgranstrom/osc.nvim",
    "davidgranstrom/scnvim-logger",
    "davidgranstrom/scnvim-tmux",
    -- Assorted SuperCollider hacks
    "madskjeldgaard/nvim-supercollider-piano",
    "madskjeldgaard/vim-scdoc-snippets",
    {
      "madskjeldgaard/supercollider-h4x-nvim",
      config = function()
        if not vim.g.IS_WINDOWS then
          require("supercollider-h4x").setup()
        end
      end,
      ft = "supercollider",
      dependencies = {
        "davidgranstrom/scnvim",
      },
    },
    { "madskjeldgaard/fzf-sc", dependencies = { "vijaymarupudi/nvim-fzf" } },
  },
  config = function()
    local scnvim = require("scnvim")
    local scnvim_path = require("scnvim.path")
    local map = scnvim.map
    local map_expr = scnvim.map_expr

    -- K - help
    -- g] - go to definition

    local cmd = vim.g.OS_HOME .. "/utils/scripts/sclang"
    if vim.g.IS_WINDOWS then
      cmd = "C:\\Documents\\SuperCollider-3.13.0\\sclang.exe"
    end

    scnvim.setup({
      sclang = {
        cmd = cmd,
      },
      keymaps = {
        ["<leader>li"] = map("editor.send_line", { "n" }),
        ["<C-e>"] = {
          map("editor.send_block", { "n" }),
          map("editor.send_selection", "x"),
        },
        -- ["<leader>sl"] = map("postwin.toggle"),
        ["<leader>cl"] = map("postwin.clear", { "n" }),
        ["<leader>."] = map("sclang.hard_stop", { "n" }),
        ["<leader>st"] = map("sclang.start"),
        ["<leader>sk"] = map("sclang.recompile"),
        ["<leader>sp"] = map_expr("Server.local.plotTree", { "n" }),
        ["<leader>sm"] = map_expr("Server.local.meter", { "n" }),
        ["<leader>sb"] = map_expr("s.boot"),
        ["<leader>sr"] = map_expr("s.reboot"),
        ["<leader>sq"] = map_expr("s.quit"),
        ["<leader>rt"] = map(function()
          vim.cmd("SCNvimGenerateAssets")
        end, { "n" }),
        ["<leader>sl"] = map(function()
          vim.cmd("SCNvimStatusLine")
        end, { "n" }),
        ["<leader>+"] = map_expr("s.volume = s.volume.volume + 5"),
        ["<leader>-"] = map_expr("s.volume = s.volume.volume - 5"),
        ["<space>k"] = map("signature.show", { "n" }),
        -- FzfSC
        ["<leader>sf"] = scnvim.map(function()
          vim.cmd("FzfSC")
        end, { "n" }),
        -- h4x
        ["<leader>se"] = scnvim.map(function()
          vim.cmd("SCExternalHelpSearch")
          -- vim.cmd("!brave file:///home/mads/.local/share/SuperCollider/Help/Help.html")
        end, { "n" }),
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
          enabled = false,
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
          size = "15%",
          cmd = "tail",
          args = { "-F", "$1" },
        },
        logger = {
          path = "/tmp/scnvim-logs.txt",
        },
      },
    })

    scnvim.load_extension("logger")
    -- scnvim.load_extension("tmux")
    scnvim.load_extension("piano")
    scnvim.load_extension("fzf-sc")

    local snippets_path = scnvim_path.get_asset("snippets")
    local snippets_path_exists = vim.fn.filereadable(snippets_path) == 1
    if snippets_path_exists then
      require("luasnip").add_snippets("supercollider", require("scnvim/utils").get_snippets())
    end
  end,
}
