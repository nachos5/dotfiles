local Path = require("plenary.path")
local nnoremap = require("keymap").nnoremap

local function get_current_buffer_path()
  -- Get the full path of the current buffer.
  local buffer_path = vim.fn.expand("%:p")

  -- If the buffer has no associated file, handle accordingly.
  if buffer_path == "" then
    vim.api.nvim_err_writeln("Buffer has no file path.")
    return nil
  end

  return buffer_path
end

local function get_directory(filepath)
  -- Create a Path object and get the parent directory.
  local directory = Path:new(filepath):parent()

  -- Convert the Path object to a string to return the directory path.
  return tostring(directory)
end

local function get_lines(content, should_trim)
  local lines = {}
  for line in content:gmatch("[^\r\n]+") do
    if should_trim then
      -- Trim leading and trailing whitespace from the line.
      line = line:match("^%s*(.-)%s*$")
    end
    -- Check if the line is not empty and does not start with '#'.
    if line ~= "" and not line:find("^#") then
      table.insert(lines, line)
    end
  end
  return lines
end

local function parse_dotenv(dotenv_lines)
  local env_vars = {}
  for line in dotenv_lines:gmatch("[^\r\n]+") do
    local key, value = line:match("([^=]+)=(.*)")
    if key and value then
      key = key:match("^%s*(.-)%s*$") -- Trim whitespace from both ends.
      value = value:match("^%s*(.-)%s*$") -- Trim whitespace from both ends.
      env_vars[key] = value
    end
  end
  return env_vars
end

local function replace_placeholders(content, env_vars)
  for key, value in pairs(env_vars) do
    content = content:gsub("{{" .. key .. "}}", value)
  end
  return content
end

local function get_env_vars()
  local buffer_path = get_current_buffer_path()
  if not buffer_path then
    vim.api.nvim_err_writeln("Buffer has no file path.")
    return nil
  end

  -- Check if this is a json file.
  local match = string.match(buffer_path, "%.json$")
  if not match then
    vim.api.nvim_err_writeln("The file is not a JSON file.")
    return nil
  end

  local json_file, err = io.open(buffer_path, "r")
  if not json_file then
    vim.api.nvim_err_writeln("Error opening file: " .. err)
    return nil
  end

  -- Read the entire contents
  local json_content = json_file:read("*a") -- Read the whole file
  json_content = json_content:gsub("[\n\r]+", " ") -- Replace newlines and carriage returns with a single space
  json_file:close()

  -- Prepare lines.
  local lines = {}

  -- Add .env variables if it exists.
  local buffer_dir = get_directory(buffer_path)
  local dotenv_file = io.open(buffer_dir .. "/.env", "r")
  if dotenv_file then
    local dotenv_content = dotenv_file:read("*a")
    dotenv_file:close()
    local dotenv_lines = get_lines(dotenv_content, true)
    local parsed_dotenv = parse_dotenv(dotenv_content)
    -- Replace placeholders in json file with env variables.
    json_content = replace_placeholders(json_content, parsed_dotenv)
    -- Append dotenv lines.
    vim.list_extend(lines, dotenv_lines)
  end

  -- Add json data env.
  table.insert(lines, "JSON_DATA='" .. json_content .. "'")

  -- Join all lines with a space.
  return table.concat(lines, " ")
end

local function run_script(run_sh_path, env_vars)
  local handle, err = io.popen(env_vars .. " " .. tostring(run_sh_path) .. " 2>&1", "r") -- Redirect stderr to stdout.
  if not handle then
    vim.api.nvim_err_writeln("Error running script: " .. err)
    return
  end

  local result = handle:read("*a")
  handle:close()

  local lines = get_lines(result, false)

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
  local env_vars = get_env_vars()
  if not env_vars then
    return
  end

  local current_buffer_dir = get_directory(get_current_buffer_path())
  if current_buffer_dir then
    -- Construct the path to run.sh in the current buffer's directory.
    local run_sh_path = Path:new(current_buffer_dir, "run.sh")
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
