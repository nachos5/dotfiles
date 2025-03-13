return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = {
    "tpope/vim-rhubarb",
  },
  config = function()
    local default_branch_name = require("env").config.GIT_DEFAULT_BRANCH

    local nnoremap = require("keymap").nnoremap
    local shared_opts = { silent = true }

    nnoremap("<leader>gs", ":Git<CR>", shared_opts)
    nnoremap("<leader>gll", ":Gclog<cr>", shared_opts)
    -- % is current buffer, # current branch
    nnoremap("<leader>glb", ":Gclog %<cr>", shared_opts)
    nnoremap("<leader>glm", ":Gclog " .. default_branch_name .. "..# --<cr>", shared_opts)
    nnoremap("<leader>gc", ":Git commit<cr>", shared_opts)
    nnoremap("<leader>ga", ":Git add %<cr>", shared_opts)
    nnoremap("<leader>gd", ":Gvdiffsplit!<CR>", shared_opts)
    nnoremap("<leader>gm", ":Gvdiffsplit " .. default_branch_name .. "<CR>", shared_opts)
    -- nnoremap("<leader>gb", ":Git blame<CR>", shared_opts)
    nnoremap("<leader>gt", ":Git mergetool<CR>", shared_opts)
    nnoremap("<leader>gr", ":GBrowse<CR>", shared_opts)
    nnoremap("<leader>gp", ":Git push<CR>", shared_opts)
    nnoremap("<leader>gf", ":Git fetch<CR>", shared_opts)

    -- get from left
    nnoremap("<leader>g<left>", ":diffget //2<cr>", shared_opts)
    -- get from right
    nnoremap("<leader>g<right>", ":diffget //3<cr>", shared_opts)

    nnoremap("<leader>geh", ":Gedit<CR>", shared_opts)
    nnoremap("<leader>ge1", ":Gedit HEAD~1:%<CR>", shared_opts)
    nnoremap("<leader>ge2", ":Gedit HEAD~2:%<CR>", shared_opts)
    nnoremap("<leader>ge3", ":Gedit HEAD~3:%<CR>", shared_opts)

    ---@param from string
    ---@param to string
    local function changed_files_to_quickfix_list(from, to)
      -- Get the git root directory
      local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")

      -- Get the list of changed files
      local changed_files = vim.fn.systemlist("git diff --name-only " .. from .. ".." .. to)

      -- Create a quickfix list with proper format
      local qf_list = {}
      for _, file in ipairs(changed_files) do
        table.insert(qf_list, {
          filename = git_root .. "/" .. file,
          lnum = 1, -- Default to line 1
          col = 1, -- Default to column 1
          text = "Changed in " .. from .. ".." .. to,
        })
      end

      -- Set the quickfix list
      vim.fn.setqflist(qf_list)

      -- Open the quickfix list
      vim.cmd("copen")
      vim.notify("Changed files loaded into quickfix list (" .. #changed_files .. " files)", vim.log.levels.INFO)
    end

    -- Create a user command for changed files.
    vim.api.nvim_create_user_command("GDF", function(opts)
      local args = opts.args
      local from, to = nil, nil

      if args and args ~= "" then
        -- Split the arguments by space.
        local split_args = vim.split(args, " ")
        from = split_args[1]
        to = split_args[2]
      end

      if from == nil or to == nil then
        vim.notify("Missing 'from' or 'to' (or both)", vim.log.levels.ERROR)
        return
      end

      changed_files_to_quickfix_list(from, to)
    end, {
      nargs = "*",
      desc = "List changed files between git refs in quickfix list",
      complete = "custom,v:lua.require'plugins.vim-fugitive'.git_ref_complete",
    })
  end,
}
