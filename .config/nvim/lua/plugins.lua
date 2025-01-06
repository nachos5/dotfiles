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
  require("plugins/nvim-treesitter"),
  require("plugins/lualine"),

  -- theme
  "gruvbox-community/gruvbox",
  require("plugins/tokyonight"),

  -- various / utils / uncategorized
  require("plugins/autopairs"),
  "windwp/nvim-ts-autotag",
  require("plugins/tabout"),
  require("plugins/which_key"),

  require("plugins/trim"),
  require("plugins/live_command"),
  require("plugins/neoscroll"),
  require("plugins/refactoring"),
  require("plugins/help_vsplit"),
  require("plugins/mini"),
  require("plugins/precognition"),
  -- require("plugins/hardtime"),
  {
    -- Handle large files.
    "LunarVim/bigfile.nvim",
  },
  require("plugins/orphans"),

  -- navigation terminal + navigation
  require("plugins/nvim-tree"),
  require("plugins/oil"),
  "christoomey/vim-tmux-navigator",
  require("plugins/harpoon"),

  -- terminal
  require("plugins/toggleterm"),
  require("plugins/term_edit"),

  -- telescope
  require("plugins/telescope"),

  -- tests/debug
  require("plugins/nvim-dap"),
  require("plugins/neotest"),

  -- git
  require("plugins/vim-fugitive"),
  require("plugins/gitsigns"),
  require("plugins/diffview"),
  -- require("plugins/octo"),

  -- snippets
  require("plugins/luasnip"),

  -- lsp
  require("plugins/mason"),
  require("plugins/cmp"),
  require("plugins/fidget"),
  require("plugins/trouble"),
  {
    "folke/neodev.nvim",
  },
  require("plugins/null-ls/init"),
  require("plugins/emmet"),
  -- lsp addons
  -- "jose-elias-alvarez/typescript.nvim",
  "simrat39/rust-tools.nvim",
  "lvimuser/lsp-inlayhints.nvim",

  -- LLM
  require("plugins/copilot"),
  require("plugins/claude"),
  require("plugins/avante"),

  -- supercollider
  require("plugins/scnvim"),

  -- notes
  -- require("plugins/mind"),

  -- colors
  require("plugins/ccc"),

  -- comments
  require("plugins/comment"),
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },

  -- database
  require("plugins/vim-dadbod"),

  -- random / various / third party
  require("plugins/leetcode"),
}, config)
