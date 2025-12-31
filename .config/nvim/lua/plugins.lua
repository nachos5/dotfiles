-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
  { "willothy/wezterm.nvim", config = true },

  -- theme
  "gruvbox-community/gruvbox",
  require("plugins/tokyonight"),

  -- env, project management etc.
  require("plugins/neoscopes/neoscopes"),

  -- various / utils / uncategorized
  require("plugins/tabout"),
  require("plugins/which_key"),

  require("plugins/trim"),
  require("plugins/live_command"),
  require("plugins/neoscroll"),
  require("plugins/help_vsplit"),
  require("plugins/mini"),
  require("plugins/precognition"),
  -- require("plugins/hardtime"),
  {
    -- Handle large files.
    "LunarVim/bigfile.nvim",
  },
  require("plugins/orphans"),
  require("plugins/translate"),

  -- refactoring
  require("plugins/refactoring"),
  require("plugins/replacer"),

  -- navigation
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
  require("plugins/lsp"),
  require("plugins/cmp"),
  require("plugins/fidget"),
  require("plugins/trouble"),
  {
    "folke/neodev.nvim",
  },
  require("plugins/null-ls/init"),
  require("plugins/emmet"),
  -- lsp addons
  "simrat39/rust-tools.nvim",
  "lvimuser/lsp-inlayhints.nvim",

  -- LLM
  require("plugins/copilot"),
  -- require("plugins/claude"),
  -- require("plugins/avante"),
  require("plugins/magenta"),

  -- supercollider
  require("plugins/scnvim"),

  -- colors
  require("plugins/ccc"),

  -- python
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
  -- require("plugins/molten"),
  -- require("plugins/image"),

  -- database
  require("plugins/vim-dadbod"),

  -- random / various / third party
  require("plugins/leetcode"),
  -- require("plugins/godot"),
}, config)
