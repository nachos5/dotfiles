local Remap = require("keymap")
local nnoremap = Remap.nnoremap

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

nnoremap("<leader>ff", "<cmd>Telescope find_files shorten_path=true<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers sort_mru=true<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>fr", "<cmd>Telescope resume<cr>")

nnoremap("<leader>fc", "<cmd>Telescope commands<cr>")
nnoremap("<leader>fk", "<cmd>Telescope keymaps<cr>")
