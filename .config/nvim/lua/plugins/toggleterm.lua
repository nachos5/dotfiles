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

local venv_path = vim.env.VENV_PATH and vim.env.VENV_PATH or "env"
local env_pre_cmd = "source ./" .. venv_path .. "/bin/activate || true"
local lg_pre_cmd = "(" .. env_pre_cmd .. ") && "
local lg_cmd = lg_pre_cmd .. "lazygit -p $(pwd)"
if vim.v.servername ~= nil then
  lg_cmd = lg_pre_cmd
      .. string.format("NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml -p $(pwd)", vim.v.servername)
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

local ld_cmd = "lazydocker"
LAZYDOCKER_TERM = Terminal:new({
  cmd = ld_cmd,
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

-- #### MAPPINGS #### --

-- <leader><C-f> for a floating terminal
function floating_toggle()
  if LAZYGIT_TERM:is_open() then
    LAZYGIT_TERM:close()
  end
  if LAZYDOCKER_TERM:is_open() then
    LAZYDOCKER_TERM:close()
  end
  if XPLR_TERM:is_open() then
    XPLR_TERM:close()
  end
  FLOATING_TERM:toggle()
end

vim.api.nvim_set_keymap("n", "<leader><C-f>", "<cmd>lua floating_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader><C-f>", "<cmd>lua floating_toggle()<CR>", { noremap = true, silent = true })

-- <C-g> for a lazygit floating terminal
function lazygit_toggle()
  if FLOATING_TERM:is_open() then
    FLOATING_TERM:close()
  end
  if LAZYDOCKER_TERM:is_open() then
    LAZYDOCKER_TERM:close()
  end
  if XPLR_TERM:is_open() then
    XPLR_TERM:close()
  end
  LAZYGIT_TERM:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-g>", "<cmd>lua lazygit_toggle()<CR>", { noremap = true, silent = true })

-- <leader><C-d> for a lazydocker floating terminal
function lazydocker_toggle()
  if FLOATING_TERM:is_open() then
    FLOATING_TERM:close()
  end
  if LAZYGIT_TERM:is_open() then
    LAZYGIT_TERM:close()
  end
  if XPLR_TERM:is_open() then
    XPLR_TERM:close()
  end
  LAZYDOCKER_TERM:toggle()
end

vim.api.nvim_set_keymap("n", "<leader><C-d>", "<cmd>lua lazydocker_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader><C-d>", "<cmd>lua lazydocker_toggle()<CR>", { noremap = true, silent = true })

-- <leader><C-x> for a xplr floating terminal
function xplr_toggle()
  if FLOATING_TERM:is_open() then
    FLOATING_TERM:close()
  end
  if LAZYGIT_TERM:is_open() then
    LAZYGIT_TERM:close()
  end
  if LAZYDOCKER_TERM:is_open() then
    LAZYDOCKER_TERM:close()
  end
  XPLR_TERM:toggle()
end

vim.api.nvim_set_keymap("n", "<leader><C-x>", "<cmd>lua xplr_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader><C-x>", "<cmd>lua xplr_toggle()<CR>", { noremap = true, silent = true })
