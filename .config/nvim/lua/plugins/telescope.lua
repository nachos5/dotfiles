local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.load_extension("harpoon")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    file_ignore_patterns = {
      ".git/",
      "node_modules",
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
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        },
      },
    },
  },
})

nnoremap("<leader>ff", "<cmd>Telescope find_files shorten_path=true<CR>")
nnoremap("<leader>gff", "<cmd>Telescope find_files shorten_path=true no_ignore=true<CR>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers sort_mru=true<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")
nnoremap("<leader>fr", "<cmd>Telescope resume<CR>")

nnoremap("<leader>fc", "<cmd>Telescope commands<CR>")
nnoremap("<leader>fk", "<cmd>Telescope keymaps<CR>")

-- pipe selection into live_grep
local default_opts = { noremap = true, silent = true }
vnoremap("<leader>fg", '"zy:Telescope live_grep default_text=<C-r>z<CR>', default_opts)
