require("oil").setup({
  columns = { "icon" },
  keymaps = {
    ["<C-h>"] = false, -- actions.select_split
    ["<C-l>"] = false, -- actions.refresh
  },
  view_options = {
    show_hidden = true,
  },
})

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open parent directory in floating window
vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
