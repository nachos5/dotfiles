return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup({
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
    --   oil.toggle_float,
    --   { desc = "Open parent directory in a floating window" }
    -- )

    -- Open CWD in current window.
    vim.keymap.set("n", "<leader>-", function()
      oil.open(vim.fn.getcwd())
    end, { desc = "Open root directory" })

    local function oil_z(args)
      local search_string = args.fargs[1]
      local command = "~/z_out.sh " .. search_string
      local handle = io.popen(command, "r")
      if handle then
        local result = handle:read("*a") -- Read the complete output of the command.
        handle:close()
        oil.open(vim.fn.trim(result))
      end
    end
    vim.api.nvim_create_user_command("Z", oil_z, { nargs = 1 })

    -- ############# --
    -- ### NOTES ### --
    -- ############# --

    local function set_created_asc_sort()
      oil.set_sort({
        { "type", "asc" },
        { "ctime", "asc" },
      })
    end

    -- Open global notes.
    vim.keymap.set("n", "<leader>mm", function()
      oil.open("/home/gulli/github/notes/tree/global")
      set_created_asc_sort()
    end, { desc = "Open global notes" })
    if vim.g.MY_CONFIG.NOTES_PROJECT_NAME ~= nil then
      -- Open local (project) notes.
      vim.keymap.set("n", "<leader>mp", function()
        oil.open("/home/gulli/github/notes/tree/" .. vim.g.MY_CONFIG.NOTES_PROJECT_NAME)
        set_created_asc_sort()
      end, { desc = "Open global notes" })
    end

    -- Telescope grep.
    vim.keymap.set(
      "n",
      "<leader>mG",
      "<cmd>lua require('plugins/telescope/custom_rg')({ cwd = '/home/gulli/github/notes/tree/global' })<CR>"
    )
    if vim.g.MY_CONFIG.NOTES_PROJECT_NAME ~= nil then
      vim.keymap.set(
        "n",
        "<leader>mg",
        "<cmd>lua require('plugins/telescope/custom_rg')({ cwd = '/home/gulli/github/notes/tree/"
          .. vim.g.MY_CONFIG.NOTES_PROJECT_NAME
          .. "' })<CR>"
      )
    end

    -- Telescope find files.
    vim.keymap.set(
      "n",
      "<leader>mS",
      "<cmd>lua require('telescope.builtin').find_files({ shorten_path = true, cwd = '/home/gulli/github/notes/tree/global' })<CR>"
    )
    if vim.g.MY_CONFIG.NOTES_PROJECT_NAME ~= nil then
      vim.keymap.set(
        "n",
        "<leader>ms",
        "<cmd>lua require('telescope.builtin').find_files({ shorten_path = true, cwd = '/home/gulli/github/notes/tree/"
          .. vim.g.MY_CONFIG.NOTES_PROJECT_NAME
          .. "' })<CR>"
      )
    end
  end,
}
