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
  dev = {
    path = "~/github",
    patterns = {},
    fallback = false,
  },
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
      "hiphish/rainbow-delimiters.nvim",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    version = "nightly",             -- optional, updated every week. (see issue #1193)
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
      "nvim-tree/nvim-web-devicons",
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
        ft_blocklist = { "markdown" },
        patterns = {
          [[%s/\s\+$//e]],          -- remove unwanted spaces
          [[%s/\($\n\s*\)\+\%$//]], -- trim last line
          [[%s/\%^\n\+//]],         -- trim first line
        },
      })
    end,
  },
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
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("plugins/mini")
    end,
  },
  -- {
  --  "m4xshen/hardtime.nvim",
  --  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --  config = function()
  --    require("plugins/hardtime")
  --  end,
  -- },

  -- terminal + navigation
  {
    "akinsho/toggleterm.nvim",
    version = "*",
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
    version = "0.1.3",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("plugins/telescope")
    end,
  },

  -- tests/debug
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
  },
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
    dependencies = {
      "tpope/vim-rhubarb",
    },
    config = function()
      require("plugins/vim-fugitive")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins/gitsigns")
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("plugins/diffview")
    end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins/octo")
    end,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
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
      -- "ray-x/lsp_signature.nvim",
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
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("plugins/fidget")
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins/trouble")
    end,
  },
  {
    "folke/neodev.nvim",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
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

  {
    "github/copilot.vim",
    config = function()
      require("plugins/copilot")
    end,
  },

  -- supercollider

  {
    "davidgranstrom/scnvim",
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
          require("supercollider-h4x").setup()
        end,
        ft = "supercollider",
        dependencies = {
          "davidgranstrom/scnvim",
        },
      },
      { "madskjeldgaard/fzf-sc", dependencies = { "vijaymarupudi/nvim-fzf" } },
    },
    config = function()
      require("plugins/scnvim")
    end,
  },

  -- notes
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

  -- python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },

  -- database
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("plugins/vim-dadbod").setup()
    end,
  },

  -- networking
  {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("plugins/rest")
    end,
  },
}, config)
