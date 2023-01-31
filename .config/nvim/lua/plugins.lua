local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local config = {
  lockfile = "~/github/dotfiles/lazy-lock.json",
}

require("lazy").setup({
  -- core
  "nvim-lua/plenary.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins/nvim-treesitter")
    end,
    dependencies = {
      "mrjones2014/nvim-ts-rainbow",
    },
  },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
    version = "nightly", -- optional, updated every week. (see issue #1193)
    config = function()
      require("plugins/nvim-tree")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins/lualine")
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },

  -- theme
  "gruvbox-community/gruvbox",
  {
    "folke/tokyonight.nvim",
    config = function()
      require("plugins/tokyonight")
    end,
  },

  -- various / utils / uncategorized
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins/autopairs")
    end,
  },
  "windwp/nvim-ts-autotag",
  {
    "abecodes/tabout.nvim",
    config = function()
      require("plugins/tabout")
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("plugins/surround")
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
  -- Trim whitespace from ends of lines automatically
  {
    "cappyzawa/trim.nvim",
    config = function()
      require("trim").setup({
        -- if you want to ignore markdown file.
        -- you can specify filetypes.
        disable = { "markdown" },
        patterns = {
          [[%s/\s\+$//e]], -- remove unwanted spaces
          [[%s/\($\n\s*\)\+\%$//]], -- trim last line
          [[%s/\%^\n\+//]], -- trim first line
        },
      })
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("plugins/glow")
    end,
  },
  "moll/vim-bbye",
  {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
        },
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("plugins/neoscroll")
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   config = function()
  --     require("plugins/noice")
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  -- },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("plugins/refactoring")
    end,
  },
  {
    "anuvyklack/help-vsplit.nvim",
    config = function()
      require("help-vsplit").setup()
    end,
  },

  -- terminal + navigation
  {
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    config = function()
      require("plugins/toggleterm")
    end,
  },
  "christoomey/vim-tmux-navigator",
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("plugins/harpoon")
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.0",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("plugins/telescope")
    end,
  },
  "nvim-telescope/telescope-file-browser.nvim",

  -- tests/debug
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "vim-test/vim-test",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
    },
    config = function()
      require("plugins/neotest")
    end,
  },

  -- git
  {
    "tpope/vim-fugitive",
    config = function()
      require("plugins/vim-fugitive")
    end,
  },
  {
    "airblade/vim-gitgutter",
    config = function()
      require("plugins/git-gutter")
    end,
  },
  "rhysd/conflict-marker.vim",
  {
    "almo7aya/openingh.nvim",
    config = function()
      require("plugins/openingh")
    end,
  },
  "sindrets/diffview.nvim",

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins/luasnip")
    end,
  },

  -- lsp
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      require("plugins/mason")
    end,
  },
  {
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
      require("plugins/cmp")
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("plugins/fidget")
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins/trouble")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- commit = "457ddb9",
    config = function()
      require("plugins/null-ls")
    end,
  },
  {
    "mattn/emmet-vim",
    event = "InsertEnter",
    ft = {
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    config = function()
      require("plugins/emmet")
    end,
  },
  -- lsp addons
  "jose-elias-alvarez/typescript.nvim",
  "simrat39/rust-tools.nvim",
  "lvimuser/lsp-inlayhints.nvim",

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("plugins/copilot")
      end, 100)
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },

  -- supercollider

  -- https://codeberg.org/madskjeldgaard/dotfiles/src/branch/main/nvim/lua/plugins.lua
  {
    "davidgranstrom/scnvim",
    dependencies = {
      "davidgranstrom/osc.nvim",
      "davidgranstrom/scnvim-logger",
      "davidgranstrom/scnvim-tmux",
      -- Assorted SuperCollider hacks
      "madskjeldgaard/nvim-supercollider-piano",
      "madskjeldgaard/vim-scdoc-snippets",
      {
        "madskjeldgaard/supercollider-h4x-nvim",
        config = function()
          require("supercollider-h4x").setup()
        end,
        ft = "supercollider",
        dependencies = {
          "davidgranstrom/scnvim",
        },
      },
      { "madskjeldgaard/fzf-sc", dependencies = {
        "vijaymarupudi/nvim-fzf",
      } },
      -- {
      --   "madskjeldgaard/sc-scratchpad.nvim",
      --   dependencies = { "davidgranstrom/scnvim" },
      --   config = function()
      --     -- Scratchpad
      --     require("sc-scratchpad").setup({
      --       keymaps = {
      --         toggle = "<space>", -- Open/close buffer
      --         send = "<C-e>", -- Send and close
      --       },
      --       border = "double", -- "double", "none", "rounded", "shadow", "single" or "solid"
      --       position = "50%",
      --       width = "50%",
      --       height = "50%",
      --       firstline = "// Scratchpad",
      --       open_insertmode = true, -- Open scratchpad buffer in insertmode
      --       close_on_execution = false, -- Should the window automatically close on exec?
      --     })
      --   end,
      -- },
    },
    config = function()
      require("plugins/scnvim")
    end,
  },

  -- supercollider requirements
  "MunifTanjim/nui.nvim",
  "junegunn/fzf",
  "junegunn/fzf.vim",

  -- formatting
  -- {
  --   "mhartington/formatter.nvim",
  --   config = function()
  --     require("plugins/formatter")
  --   end,
  -- },

  -- notes
  "nvim-orgmode/orgmode",
  {
    "phaazon/mind.nvim",
    branch = "v2.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins/mind")
    end,
  },

  -- colors
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({})
    end,
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins/comment")
    end,
  },
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- random useless stuff / for fun
  {
    "tamton-aquib/duck.nvim",
    config = function()
      vim.keymap.set("n", "<leader>dd", function()
        require("duck").hatch()
      end, {})
      vim.keymap.set("n", "<leader>dk", function()
        require("duck").cook()
      end, {})
    end,
  },
}, config)
