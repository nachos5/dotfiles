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

local function oil_z(args)
  local search_string = args.fargs[1]
  local command = "~/z_out.sh " .. search_string
  local handle = io.popen(command, "r")
  if handle then
    local result = handle:read("*a") -- Read the complete output of the command
    handle:close()
    require("oil").open(vim.fn.trim(result))
  end
end
vim.api.nvim_create_user_command("Z", oil_z, { nargs = 1 })
