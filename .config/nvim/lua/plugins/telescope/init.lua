local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local telescope = require("telescope")
local actions = require("telescope.actions")
local custom_actions = require("plugins/telescope/custom_actions")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    file_ignore_patterns = {
      ".git/",
      "node_modules",
    },
    mappings = {
      i = {
        ["<C-e>"] = custom_actions.yank_all_entries,
        ["<C-l>"] = custom_actions.yank_preview_lines,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = function(opts)
        return { "--hidden" }
      end,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
        },
      },
    },
  },
})

telescope.load_extension("env")
telescope.load_extension("harpoon")
telescope.load_extension("ui-select")

local default_opts = { noremap = true, silent = true }

-- pickers
nnoremap("<leader>tep", "<cmd>Telescope<CR>", default_opts)

-- env
nnoremap("<leader>tee", "<cmd>Telescope env<CR>", default_opts)

-- file and buffer stuff
nnoremap("<leader>ff", "<cmd>Telescope find_files shorten_path=true<CR>", default_opts)
nnoremap("<leader>gff", "<cmd>Telescope find_files shorten_path=true no_ignore=true<CR>", default_opts)
nnoremap("<leader>fg", "<cmd>lua require('plugins/telescope/multi_rg')()<CR>", default_opts)
nnoremap("<leader>fb", "<cmd>Telescope buffers sort_mru=true<CR>", default_opts)
nnoremap("<leader>fr", "<cmd>Telescope resume<CR>", default_opts)
-- pipe selection into live_grep
vnoremap("<leader>fg", '"zy:Telescope live_grep default_text=<C-r>z<CR>', default_opts)

-- lsp stuff
nnoremap("<leader>ci", "<cmd>Telescope lsp_incoming_calls<CR>")
nnoremap("<leader>co", "<cmd>Telescope lsp_outgoing_calls<CR>")
