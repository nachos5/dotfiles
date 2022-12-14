-- Automatically recompile packer when updating this config file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup en
]])
-- -----------------------------------
-- Boot strap
-- If packer is not installed, tis will install it
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end
-- -----------------------------------
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
  function()
    if packer_bootstrap then
      require("packer").sync()
    end

    -- core
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("plugins/nvim-treesitter")
      end,
    })
    use({
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icons
      },
      tag = "nightly", -- optional, updated every week. (see issue #1193)
      config = function()
        require("plugins/nvim-tree")
      end,
    })
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins/lualine")
      end,
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true,
      },
    })

    -- theme
    use("gruvbox-community/gruvbox")
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("plugins/tokyonight")
      end,
    })

    -- various / utils / uncategorized
    use({
      "windwp/nvim-autopairs",
      after = {
        "nvim-cmp",
      },
      config = function()
        require("plugins/autopairs")
      end,
    })
    use("windwp/nvim-ts-autotag")
    use({
      "abecodes/tabout.nvim",
      after = {
        "nvim-autopairs",
      },
      config = function()
        require("plugins/tabout")
      end,
    })
    use({
      "kylechui/nvim-surround",
      config = function()
        require("plugins/surround")
      end,
    })
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup()
      end,
    })
    -- Trim whitespace from ends of lines automatically
    use({
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
    })
    use({
      "ellisonleao/glow.nvim",
      config = function()
        require("plugins/glow")
      end,
    })
    use("moll/vim-bbye")
    use({
      "smjonas/live-command.nvim",
      -- live-command supports semantic versioning via tags
      -- tag = "1.*",
      config = function()
        require("live-command").setup({
          commands = {
            Norm = { cmd = "norm" },
          },
        })
      end,
    })
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("plugins/neoscroll")
      end,
    })
    -- use({
    --   "folke/noice.nvim",
    --   event = "VimEnter",
    --   config = function()
    --     require("noice").setup()
    --   end,
    --   requires = {
    --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --     "MunifTanjim/nui.nvim",
    --   },
    -- })
    use({
      "ThePrimeagen/refactoring.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
      },
      config = function()
        require("plugins/refactoring")
      end,
    })
    use({
      "anuvyklack/help-vsplit.nvim",
      config = function()
        require("help-vsplit").setup()
      end,
    })

    -- terminal + navigation
    use({
      "akinsho/toggleterm.nvim",
      tag = "v2.*",
      after = {
        "tokyonight.nvim",
      },
      config = function()
        require("plugins/toggleterm")
      end,
    })
    use("christoomey/vim-tmux-navigator")
    use({
      "ThePrimeagen/harpoon",
      config = function()
        require("plugins/harpoon")
      end,
    })

    -- telescope
    use({
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("plugins/telescope")
      end,
    })
    use("nvim-telescope/telescope-file-browser.nvim")

    -- tests/debug
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use({
      "nvim-neotest/neotest",
      requires = {
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
    })

    -- git
    use({
      "tpope/vim-fugitive",
      config = function()
        require("plugins/vim-fugitive")
      end,
    })
    use({
      "airblade/vim-gitgutter",
      config = function()
        require("plugins/git-gutter")
      end,
    })
    use("rhysd/conflict-marker.vim")
    use({
      "almo7aya/openingh.nvim",
      config = function()
        require("plugins/openingh")
      end,
    })

    -- snippets
    use({
      "L3MON4D3/LuaSnip",
      config = function()
        require("plugins/luasnip")
      end,
    })

    -- lsp
    use({
      "williamboman/mason.nvim",
      requires = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "ray-x/lsp_signature.nvim",
      },
      config = function()
        require("plugins/mason")
      end,
    })
    use({
      "hrsh7th/nvim-cmp",
      requires = {
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
    })
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("plugins/fidget")
      end,
    })
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins/trouble")
      end,
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      -- commit = "457ddb9",
      config = function()
        require("plugins/null-ls")
      end,
    })
    use({
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
        print("h??rna")
        require("plugins/emmet")
      end,
    })
    -- lsp addons
    use("jose-elias-alvarez/typescript.nvim")
    use("simrat39/rust-tools.nvim")
    use("lvimuser/lsp-inlayhints.nvim")

    -- use({
    --   "neoclide/coc.nvim",
    --   branch = "release",
    --   run = "yarn install",
    --   config = function()
    --     require("plugins/coc")
    --   end,
    -- })

    -- copilot
    use({
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("plugins/copilot")
        end, 100)
      end,
    })
    -- use({
    --   "zbirenbaum/copilot-cmp",
    --   after = { "copilot.lua" },
    --   config = function()
    --     require("copilot_cmp").setup()
    --   end,
    -- })

    -- supercollider

    -- https://codeberg.org/madskjeldgaard/dotfiles/src/branch/main/nvim/lua/plugins.lua
    use({
      "davidgranstrom/scnvim",
      after = { "LuaSnip" },
      requires = {
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
          after = { "scnvim" },
          requires = {
            "davidgranstrom/scnvim",
          },
        },
        { "madskjeldgaard/fzf-sc", requires = {
          "vijaymarupudi/nvim-fzf",
        } },
        -- {
        --   "madskjeldgaard/sc-scratchpad.nvim",
        --   requires = { "davidgranstrom/scnvim" },
        --   after = { "scnvim" },
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
    })

    -- supercollider requirements
    use("MunifTanjim/nui.nvim")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    -- formatting
    -- use({
    --   "mhartington/formatter.nvim",
    --   config = function()
    --     require("plugins/formatter")
    --   end,
    -- })

    -- notes
    use("nvim-orgmode/orgmode")
    use({
      "phaazon/mind.nvim",
      branch = "v2.2",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugins/mind")
      end,
    })

    -- colors
    use({
      "uga-rosa/ccc.nvim",
      config = function()
        require("ccc").setup({})
      end,
    })

    -- comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugins/comment")
      end,
    })
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- random useless stuff / for fun
    use({
      "tamton-aquib/duck.nvim",
      config = function()
        vim.keymap.set("n", "<leader>dd", function()
          require("duck").hatch()
        end, {})
        vim.keymap.set("n", "<leader>dk", function()
          require("duck").cook()
        end, {})
      end,
    })
  end,
  config = {
    profile = {
      enable = false,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
