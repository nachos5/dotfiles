local nnoremap = require("keymap").nnoremap

require("neorg").setup({
  load = {
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.keybinds"] = {}, -- Adds default keybindings
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    }, -- Enables support for completion plugins
    ["core.journal"] = {}, -- Enables support for the journal module
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/notes",
        },
        default_workspace = "notes",
      },
    },
  },
})

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>oi", "<cmd>Neorg index<CR>", default_opts)
nnoremap("<leader>or", "<cmd>Neorg return<CR>", default_opts)
