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
    { "<C-g>", "<cmd>lua TOGGLE_TERM(LAZYGIT_TERM)<CR>", mode = { "n", "t" }, desc = "Toggle lazygit" },
    { "<leader><C-d>", "<cmd>lua TOGGLE_TERM(LAZYDOCKER_TERM)<CR>", mode = { "n", "t" }, desc = "Toggle lazydocker" },
    { "<leader><C-x>", "<cmd>lua TOGGLE_TERM(XPLR_TERM)<CR>", mode = { "n", "t" }, desc = "Toggle xplr" },
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
    local lg_cmd = lg_pre_cmd .. "lazygit -p $(pwd)"
    if vim.v.servername ~= nil then
      lg_cmd = lg_pre_cmd
        .. string.format("NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.yaml -p $(pwd)", vim.v.servername)
    end
    if vim.g.IS_WINDOWS then
      lg_cmd = "lazygit"
    end
    LAZYGIT_TERM = Terminal:new({
      cmd = lg_cmd,
      direction = "float",
      hidden = true,
      float_opts = {
        height = 90,
        width = 180,
      },
    })

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

    -- #### XPLR TERMINAL #### --

    XPLR_TERM = Terminal:new({
      cmd = function()
        local xplr_cmd = "xplr"
        local current_buf_filename = utils.get_current_buffer_filename()
        if current_buf_filename ~= "" then
          xplr_cmd = xplr_cmd .. " " .. current_buf_filename
        end
        xplr_cmd = xplr_cmd .. " " .. "--print-pwd-as-result"
        return xplr_cmd
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
      LAZYGIT_TERM,
      LAZYDOCKER_TERM,
      XPLR_TERM,
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
      end, all_terms)
    end

    vim.g.my_terms.TOGGLE_TERM = TOGGLE_TERM
  end,
}
