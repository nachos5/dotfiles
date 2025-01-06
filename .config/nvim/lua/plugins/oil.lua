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

    -- ############# --
    -- ### NOTES ### --
    -- ############# --

    -- Open global notes.
    vim.keymap.set("n", "<leader>mm", function()
      require("oil").open("/home/gulli/github/notes/tree/global")
    end, { desc = "Open global notes" })
    if vim.env.NOTES_PROJECT_NAME ~= nil then
      -- Open local (project) notes.
      vim.keymap.set("n", "<leader>mp", function()
        require("oil").open("/home/gulli/github/notes/tree/" .. vim.env.NOTES_PROJECT_NAME)
      end, { desc = "Open global notes" })
    end

    -- Telescope grep.
    vim.keymap.set(
      "n",
      "<leader>mG",
      "<cmd>lua require('plugins/telescope/custom_rg')({ cwd = '/home/gulli/github/notes/tree/global' })<CR>"
    )
    if vim.env.NOTES_PROJECT_NAME ~= nil then
      vim.keymap.set(
        "n",
        "<leader>mg",
        "<cmd>lua require('plugins/telescope/custom_rg')({ cwd = '/home/gulli/github/notes/tree/"
          .. vim.env.NOTES_PROJECT_NAME
          .. "' })<CR>"
      )
    end

    -- Telescope find files.
    vim.keymap.set(
      "n",
      "<leader>mS",
      "<cmd>lua require('telescope.builtin').find_files({ shorten_path = true, cwd = '/home/gulli/github/notes/tree/global' })<CR>"
    )
    if vim.env.NOTES_PROJECT_NAME ~= nil then
      vim.keymap.set(
        "n",
        "<leader>ms",
        "<cmd>lua require('telescope.builtin').find_files({ shorten_path = true, cwd = '/home/gulli/github/notes/tree/"
          .. vim.env.NOTES_PROJECT_NAME
          .. "' })<CR>"
      )
    end
  end,
}
