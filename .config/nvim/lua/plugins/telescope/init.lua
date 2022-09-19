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

local default_opts = { noremap = true, silent = true }

nnoremap("<leader>ff", "<cmd>Telescope find_files shorten_path=true<CR>", default_opts)
nnoremap("<leader>gff", "<cmd>Telescope find_files shorten_path=true no_ignore=true<CR>", default_opts)
-- nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>", default_opts)
nnoremap("<leader>fg", "<cmd>lua require('plugins/telescope/multi_rg')()<CR>", default_opts)
nnoremap("<leader>fb", "<cmd>Telescope buffers sort_mru=true<CR>", default_opts)
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>", default_opts)
nnoremap("<leader>fr", "<cmd>Telescope resume<CR>", default_opts)

nnoremap("<leader>fc", "<cmd>Telescope commands<CR>", default_opts)
nnoremap("<leader>fk", "<cmd>Telescope keymaps<CR>", default_opts)

-- pipe selection into live_grep
vnoremap("<leader>fg", '"zy:Telescope live_grep default_text=<C-r>z<CR>', default_opts)

-- git stuff
nnoremap("<leader>ftc", "<cmd>Telescope git_commits<CR>", default_opts)
nnoremap("<leader>ftb", "<cmd>Telescope git_bcommits<CR>", default_opts)
nnoremap("<leader>fts", "<cmd>Telescope git_status<CR>", default_opts)