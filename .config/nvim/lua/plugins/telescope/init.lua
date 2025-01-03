return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "LinArcX/telescope-env.nvim",
  },
  keys = {
    -- pickers
    { "<leader>tep", "<cmd>Telescope<CR>", desc = "Open Telescope" },
    -- env
    { "<leader>tee", "<cmd>Telescope env<CR>", desc = "Telescope env vars" },
    -- file and buffer stuff
    { "<leader>ff", "<cmd>Telescope find_files shorten_path=true<CR>", desc = "Find files" },
    { "<leader>gff", "<cmd>Telescope find_files shorten_path=true no_ignore=true<CR>", desc = "Find all files" },
    { "<leader>fg", "<cmd>lua require('plugins/telescope/custom_rg')()<CR>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true<CR>", desc = "Find buffers" },
    { "<leader>fr", "<cmd>Telescope resume<CR>", desc = "Resume last picker" },
    -- pipe selection into live_grep
    { "<leader>fg", '"zy:Telescope live_grep default_text=<C-r>z<CR>', mode = "v", desc = "Grep selected text" },
    -- lsp stuff
    { "<leader>ci", "<cmd>Telescope lsp_incoming_calls<CR>", desc = "LSP incoming calls" },
    { "<leader>co", "<cmd>Telescope lsp_outgoing_calls<CR>", desc = "LSP outgoing calls" },
  },
  config = function()
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
  end,
}
