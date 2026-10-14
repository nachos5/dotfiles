return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
  keys = {
    { "<leader><C-t>", desc = "Toggle terminal" },
    {
      "<leader><C-f>",
      "<cmd>lua TOGGLE_TERM(FLOATING_TERM)<CR>",
      mode = { "n", "t" },
      desc = "Toggle floating terminal",
    },
    { "<C-g>", "<cmd>lua TOGGLE_LAZYGIT()<CR>", mode = { "n", "t" }, desc = "Toggle lazygit" },
    { "<leader><C-d>", "<cmd>lua TOGGLE_TERM(LAZYDOCKER_TERM)<CR>", mode = { "n", "t" }, desc = "Toggle lazydocker" },
    { "<leader><C-x>", "<cmd>lua TOGGLE_TERM(YAZI_TERM)<CR>", mode = { "n", "t" }, desc = "Toggle yazi" },
  },
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local utils = require("utils")

    require("toggleterm").setup({
      size = 10,
      open_mapping = [[<leader><C-t>]],
      shade_terminals = false,
    })

    -- #### FLOATING TERMINAL #### --

    FLOATING_TERM = Terminal:new({
      direction = "float",
      hidden = true,
    })

    -- #### LAZYGIT TERMINAL #### --

    local venv_path = require("env").config.VENV_PATH and require("env").config.VENV_PATH or "env"
    local env_pre_cmd = "source ./" .. venv_path .. "/bin/activate || true"
    local lg_pre_cmd = "(" .. env_pre_cmd .. ") && "
    -- One lazygit terminal per git root, so each worktree gets its own lazygit.
    local lazygit_terms = {}

    --- @param git_root string
    local function lazygit_cmd(git_root)
      if vim.g.IS_WINDOWS then
        return "lazygit"
      end
      local lg_cmd = lg_pre_cmd .. "lazygit -p " .. vim.fn.shellescape(git_root)
      if vim.v.servername ~= nil then
        lg_cmd = lg_pre_cmd
          .. string.format(
            "NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.yaml -p %s",
            vim.v.servername,
            vim.fn.shellescape(git_root)
          )
      end
      return lg_cmd
    end

    --- Get the lazygit terminal for the git root of the current buffer (worktrees included,
    --- where .git is a file). Unnamed and special buffers use the cwd.
    --- @return Terminal
    local function get_lazygit_term()
      local git_root = vim.fs.root(0, ".git") or vim.fn.getcwd()
      if lazygit_terms[git_root] == nil then
        lazygit_terms[git_root] = Terminal:new({
          cmd = lazygit_cmd(git_root),
          dir = git_root,
          direction = "float",
          hidden = true,
          float_opts = {
            height = 90,
            width = 180,
          },
        })
      end
      return lazygit_terms[git_root]
    end

    -- #### LAZYDOCKER TERMINAL #### --

    LAZYDOCKER_TERM = Terminal:new({
      cmd = "lazydocker",
      direction = "float",
      hidden = true,
      float_opts = {
        height = 90,
        width = 180,
      },
    })

    -- #### YAZI TERMINAL #### --

    YAZI_TERM = Terminal:new({
      cmd = function()
        -- Given a file path, yazi starts with that file hovered.
        local yazi_cmd = "yazi"
        local current_buf_filename = utils.get_current_buffer_filename()
        if current_buf_filename ~= "" then
          yazi_cmd = yazi_cmd .. " " .. current_buf_filename
        end
        return yazi_cmd
      end,
      direction = "float",
      hidden = true,
      float_opts = {
        height = 90,
        width = 180,
      },
      on_exit = function(_, job, exit_code, name)
        -- print(_)
        -- print(job)
        -- print(exit_code)
        -- print(name)
      end,
    })

    local all_terms = {
      FLOATING_TERM,
      LAZYDOCKER_TERM,
      YAZI_TERM,
    }
    -- Make globally accessable.
    vim.g.my_terms = all_terms

    TERM_LAST_FOCUSED_BUFFER = nil

    --- @param term_to_toggle Terminal
    function TOGGLE_TERM(term_to_toggle)
      -- Store focused buffer (before opening terminal).
      TERM_LAST_FOCUSED_BUFFER = vim.api.nvim_get_current_buf()
      -- Map through the terminals.
      vim.tbl_map(function(term)
        -- Find the one to toggle.
        if term == term_to_toggle then
          term:toggle()
        else
          -- Close the rest if needed.
          if term:is_open() then
            term:close()
          end
        end
      end, vim.list_extend(vim.list_extend({}, all_terms), vim.tbl_values(lazygit_terms)))
    end

    function TOGGLE_LAZYGIT()
      -- Inside lazygit the current buffer is the terminal, so close the open one.
      for _, term in pairs(lazygit_terms) do
        if term:is_open() then
          return TOGGLE_TERM(term)
        end
      end
      TOGGLE_TERM(get_lazygit_term())
    end

    vim.g.my_terms.TOGGLE_TERM = TOGGLE_TERM
  end,
}
