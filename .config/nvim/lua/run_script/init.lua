local Path = require("plenary.path")
local nnoremap = require("keymap").nnoremap
local utils = require("run_script.utils")
local get_env_vars = require("run_script.env_vars").get_env_vars

local function run_script(run_sh_path, env_vars)
  local handle, err = io.popen(env_vars .. " " .. tostring(run_sh_path) .. " 2>&1", "r") -- Redirect stderr to stdout.
  if not handle then
    vim.api.nvim_err_writeln("Error running script: " .. err)
    return
  end

  local result = handle:read("*a")
  handle:close()

  local lines = utils.get_lines(result, false)

  -- Create a new buffer.
  local buf = vim.api.nvim_create_buf(true, false)
  -- Split the window vertically and display the new buffer.
  vim.cmd("vsplit")
  vim.api.nvim_win_set_buf(0, buf) -- Set the newly created buffer in the current window.

  -- Add results to the buffer.
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set filetype as json.
  vim.api.nvim_set_option_value("filetype", "json", { buf = buf })
end

local function main()
  local env_vars, json_table = get_env_vars()
  if not env_vars then
    return
  end

  local current_buffer_dir = utils.get_directory(utils.get_current_buffer_path())
  if current_buffer_dir then
    -- Construct the path to run script in the current buffer's directory.
    local run_script_filename = (json_table and json_table["script_filename"]) and json_table["script_filename"]
      or "run.sh"
    local run_sh_path = Path:new(current_buffer_dir, run_script_filename)
    if run_sh_path:exists() then
      local callback = function()
        run_script(run_sh_path, env_vars)
      end
      vim.schedule_wrap(callback)()
    else
      vim.api.nvim_err_writeln("run.sh does not exist in the directory.")
    end
  else
    vim.api.nvim_err_writeln("Could not determine the current buffer's directory.")
  end
end

nnoremap("<leader>rn", main)
