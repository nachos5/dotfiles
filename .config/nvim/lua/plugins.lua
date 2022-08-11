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
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true,
        config = function()
          require("lualine").setup()
        end,
      },
    })

    -- various / utils / uncategorized
    use("nvim-orgmode/orgmode")
    use({
      "windwp/nvim-autopairs",
      after = {
        "nvim-cmp",
      },
      config = function()
        require("plugins/autopairs")
      end,
    })
    -- use({
    --   "abecodes/tabout.nvim",
    --   after = {
    --     "nvim-cmp",
    --   },
    --   config = function()
    --     require("plugins/tabout")
    --   end,
    -- })
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
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      config = function()
        require("plugins/markdown-preview")
      end,
    })

    -- terminal + navigation
    use({
      "akinsho/toggleterm.nvim",
      tag = "v2.*",
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

    -- theme
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")

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
      config = function()
        require("plugins/null-ls")
      end,
    })
    -- lsp addons
    use("jose-elias-alvarez/typescript.nvim")
    use("simrat39/rust-tools.nvim")

    -- use({
    --   "neoclide/coc.nvim",
    --   branch = "release",
    --   run = "yarn install",
    --   config = function()
    --     require("plugins/coc")
    --   end,
    -- })

    -- typescript react
    -- use("pangloss/vim-javascript")
    -- use("leafgarland/typescript-vim")
    -- use("peitalin/vim-jsx-typescript")
    -- use("jparise/vim-graphql")

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
        {
          "madskjeldgaard/sc-scratchpad.nvim",
          requires = { "davidgranstrom/scnvim" },
          after = { "scnvim" },
          config = function()
            -- Scratchpad
            require("sc-scratchpad").setup({
              keymaps = {
                toggle = "<space>", -- Open/close buffer
                send = "<C-e>", -- Send and close
              },
              border = "double", -- "double", "none", "rounded", "shadow", "single" or "solid"
              position = "50%",
              width = "50%",
              height = "50%",
              firstline = "// Scratchpad",
              open_insertmode = true, -- Open scratchpad buffer in insertmode
              close_on_execution = false, -- Should the window automatically close on exec?
            })
          end,
        },
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

    -- comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
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
