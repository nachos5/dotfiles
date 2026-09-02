return {
  "stevearc/oil.nvim",
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
      local command = "zoxide query " .. search_string
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

    local function set_notes_sort()
      oil.set_sort({
        { "type", "asc" },
        { "ctime", "desc" },
      })
    end

    local directory_mapping_path = "/home/gulli/github/notes/directory_mapping.json"

    local function normalize_path(path)
      local normalized_path = vim.fs.normalize(path)
      return (vim.uv or vim.loop).fs_realpath(normalized_path) or normalized_path
    end

    local function get_local_notes_directory()
      local mapping_file, open_error = io.open(directory_mapping_path, "r")
      if mapping_file == nil then
        return nil, "Could not open notes directory mapping: " .. open_error
      end

      local mapping_content = mapping_file:read("*a")
      mapping_file:close()

      local decoded, directory_mapping = pcall(vim.json.decode, mapping_content)
      if not decoded or type(directory_mapping) ~= "table" then
        return nil, "Could not decode notes directory mapping: " .. tostring(directory_mapping)
      end

      local current_directory = normalize_path(vim.fn.getcwd())
      local home_directory = normalize_path(vim.fn.expand("~"))
      local notes_root = vim.fs.dirname(directory_mapping_path)
      local best_match

      for notes_directory, project_directory in pairs(directory_mapping) do
        if type(notes_directory) == "string" and type(project_directory) == "string" then
          local project_path = normalize_path(vim.fs.joinpath(home_directory, project_directory))
          local is_inside_project = current_directory == project_path
            or vim.startswith(current_directory, project_path .. "/")

          if is_inside_project and (best_match == nil or #project_path > #best_match.project_path) then
            best_match = {
              project_path = project_path,
              notes_path = normalize_path(vim.fs.joinpath(notes_root, notes_directory)),
            }
          end
        end
      end

      if best_match == nil then
        return nil, "No local notes directory is mapped for " .. current_directory
      end

      return best_match.notes_path
    end

    local function with_local_notes(callback)
      local notes_directory, mapping_error = get_local_notes_directory()
      if notes_directory == nil then
        vim.notify(mapping_error, vim.log.levels.WARN)
        return
      end

      callback(notes_directory)
    end

    -- Open global notes.
    vim.keymap.set("n", "<leader>mm", function()
      oil.open("/home/gulli/github/notes/tree/global")
      set_notes_sort()
    end, { desc = "Open global notes" })
    -- Open local (project) notes.
    vim.keymap.set("n", "<leader>mp", function()
      with_local_notes(function(notes_directory)
        oil.open(notes_directory)
        set_notes_sort()
      end)
    end, { desc = "Open local notes" })

    -- Telescope grep.
    vim.keymap.set(
      "n",
      "<leader>mG",
      "<cmd>lua require('plugins/telescope/custom_rg')({ cwd = '/home/gulli/github/notes/tree/global' })<CR>"
    )
    vim.keymap.set("n", "<leader>mg", function()
      with_local_notes(function(notes_directory)
        require("plugins/telescope/custom_rg")({ cwd = notes_directory })
      end)
    end, { desc = "Grep local notes" })

    -- Telescope find files.
    vim.keymap.set(
      "n",
      "<leader>mS",
      "<cmd>lua require('telescope.builtin').find_files({ cwd = '/home/gulli/github/notes/tree/global' })<CR>"
    )
    vim.keymap.set("n", "<leader>ms", function()
      with_local_notes(function(notes_directory)
        require("telescope.builtin").find_files({ cwd = notes_directory })
      end)
    end, { desc = "Find local notes" })
  end,
}
