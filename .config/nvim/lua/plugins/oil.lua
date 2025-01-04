return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon" },
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["<C-h>"] = false, -- actions.select_split
        ["<C-l>"] = false, -- actions.refresh
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
      },
      win_options = {
        wrap = true,
      },
    })

    -- Open parent directory in current window.
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

    -- Open parent directory in floating window.
    -- vim.keymap.set(
    --   "n",
    --   "<leader>-",
    --   require("oil").toggle_float,
    --   { desc = "Open parent directory in a floating window" }
    -- )

    -- Open CWD in current window.
    vim.keymap.set("n", "<leader>-", function()
      require("oil").open(vim.fn.getcwd())
    end, { desc = "Open root directory" })

    local function oil_z(args)
      local search_string = args.fargs[1]
      local command = "~/z_out.sh " .. search_string
      local handle = io.popen(command, "r")
      if handle then
        local result = handle:read("*a") -- Read the complete output of the command.
        handle:close()
        require("oil").open(vim.fn.trim(result))
      end
    end
    vim.api.nvim_create_user_command("Z", oil_z, { nargs = 1 })
  end,
}
