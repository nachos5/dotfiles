local Path = require("plenary.path")
local nnoremap = require("keymap").nnoremap
local utils = require("run_script.utils")
local get_env_vars = require("run_script.env_vars").get_env_vars

-- Store the output buffer reference.
local output_bufnr = nil

local function get_or_create_output_buffer(lines)
  local buf
  local win

  -- Check if output buffer exists and is valid.
  if output_bufnr and vim.api.nvim_buf_is_valid(output_bufnr) then
    buf = output_bufnr
    -- Find if buffer is shown in any window.
    for _, w in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(w) == buf then
        win = w
        break
      end
    end
  else
    -- Create new buffer.
    buf = vim.api.nvim_create_buf(true, false)
    output_bufnr = buf
  end

  -- Set up buffer options.
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true

  -- Clear and update buffer content.
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value("filetype", "json", { buf = buf })
  vim.bo[buf].modifiable = false

  -- Handle window display.
  if not win then
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, buf)
  else
    -- Ensure the window is focused.
    vim.api.nvim_set_current_win(win)
  end

  return buf
end

local function run_script(run_sh_path, env_vars)
  local cmd = string.format("%s %s 2>&1", env_vars, tostring(run_sh_path))
  local handle, err = io.popen(cmd, "r")
  if not handle then
    vim.api.nvim_err_writeln("Error running script: " .. err)
    return
  end

  local result = handle:read("*a")
  local success, _, code = handle:close()

  if not success then
    vim.api.nvim_err_writeln(string.format("Script failed with exit code: %d", code))
  end

  local lines = utils.get_lines(result, false)

  return get_or_create_output_buffer(lines)
end

local function main()
  local env_vars, json_table = get_env_vars()
  if not env_vars then
    return
  end

  local buffer_path = utils.get_current_buffer_path()
  if buffer_path == nil then
    return
  end

  local current_buffer_dir = utils.get_directory(buffer_path)
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
