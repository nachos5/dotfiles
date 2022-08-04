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

    use("wbthomason/packer.nvim")

    -- Trim whitespace from ends of lines automatically
    use({
      "cappyzawa/trim.nvim",
      config = function()
        require("trim").setup({
          -- if you want to ignore markdown file.
          -- you can specify filetypes.
          disable = { "markdown" },
        })
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
      "neoclide/coc.nvim",
      branch = "release",
      run = "yarn install",
      config = function()
        require("plugins/coc")
      end,
    })

    use("nvim-lua/plenary.nvim")

    use("nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate",
    })

    use("nvim-orgmode/orgmode")

    use("nvim-lualine/lualine.nvim", {
      requires = {
        "kyazdani42/nvim-web-devicons",
        opt = true,
        config = function()
          require("lualine").setup()
        end,
      },
    })

    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    })

    use("christoomey/vim-tmux-navigator")

    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      config = function()
        require("plugins/markdown-preview")
      end,
    })

    use({
      "akinsho/toggleterm.nvim",
      tag = "v2.*",
      config = function()
        require("plugins/toggleterm")
      end,
    })

    -- use('mg979/vim-visual-multi', {branch = 'master'})

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

    -- debug
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- theme
    use("morhetz/gruvbox")

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

    use({
      "L3MON4D3/LuaSnip",
      config = function()
        require("plugins/luasnip")
      end,
    })
    use({
      "hrsh7th/nvim-cmp",
      disable = false,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "quangnguyen30192/cmp-nvim-tags",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-path",
      },
      config = function()
        require("plugins/cmp")
      end,
    })

    -- typescript react
    use("pangloss/vim-javascript")
    use("leafgarland/typescript-vim")
    use("peitalin/vim-jsx-typescript")
    use("jparise/vim-graphql")

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
    use({
      "mhartington/formatter.nvim",
      config = function()
        require("plugins/formatter")
      end,
    })

    -- comments
    -- use("scrooloose/nerdcommenter")
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
