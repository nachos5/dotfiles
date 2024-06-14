-- TODO:
-- clean and refactor
-- verify file is json

local Path = require("plenary.path")
local nnoremap = require("keymap").nnoremap

local function get_current_buffer_path()
  -- Get the full path of the current buffer.
  local buffer_path = vim.fn.expand("%:p")

  -- If the buffer has no associated file, handle accordingly.
  if buffer_path == "" then
    print("Buffer has no file path.")
    return nil
  end

  return buffer_path
end

local function get_current_buffer_directory_path()
  local buffer_path = get_current_buffer_path()

  -- Create a Path object and get the parent directory
  local directory = Path:new(buffer_path):parent()

  -- Convert the Path object to a string to return the directory path
  return tostring(directory)
end

local function get_lines(content)
  local lines = {}
  for line in content:gmatch("[^\r\n]+") do
    -- Trim leading and trailing whitespace from the line
    line = line:match("^%s*(.-)%s*$")
    -- Check if the line is not empty and does not start with '#'
    if line ~= "" and not line:find("^#") then
      table.insert(lines, line)
    end
  end
  return lines
end

local function parse_dotenv(dotenv_content)
  local env_vars = {}
  for line in dotenv_content:gmatch("[^\r\n]+") do
    local key, value = line:match("([^=]+)=(.*)")
    if key and value then
      key = key:match("^%s*(.-)%s*$") -- Trim whitespace from both ends
      value = value:match("^%s*(.-)%s*$") -- Trim whitespace from both ends
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
    print("Buffer has no file path.")
    return nil
  end

  local file, err = io.open(buffer_path, "r")
  if not file then
    print("Error opening file: " .. err)
    return nil
  end

  -- Read the entire contents
  local content = file:read("*a") -- Read the whole file
  content = content:gsub("[\n\r]+", " ") -- Replace newlines and carriage returns with a single space
  file:close()

  -- Split the content by new line and concatenate
  -- local lines = get_lines(content)
  local lines = {}

  -- Add .env variables if it exists.
  local buffer_dir = get_current_buffer_directory_path()
  local dotenv_file = io.open(buffer_dir .. "/.env", "r")
  if dotenv_file then
    local dotenv_content = dotenv_file:read("*a")
    dotenv_file:close()
    local dotenv_lines = get_lines(dotenv_content)
    local parsed_dotenv = parse_dotenv(dotenv_content)
    content = replace_placeholders(content, parsed_dotenv)
    -- Append
    vim.list_extend(lines, dotenv_lines)
  end

  table.insert(lines, "JSON_DATA='" .. content .. "'")

  -- Join all lines with a space
  return table.concat(lines, " ")
end

local function run_script(run_sh_path, env_vars)
  -- print(env_vars)
  local handle, err = io.popen(env_vars .. " " .. tostring(run_sh_path) .. " 2>&1", "r") -- Redirect stderr to stdout
  if not handle then
    print("Error running script: " .. err)
    return
  end

  local result = handle:read("*a")
  handle:close()

  local lines = get_lines(result)

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

  local current_buffer_dir = get_current_buffer_directory_path()
  if current_buffer_dir then
    -- Construct the path to run.sh in the current buffer's directory
    local run_sh_path = Path:new(current_buffer_dir, "run.sh")
    if run_sh_path:exists() then
      local callback = function()
        run_script(run_sh_path, env_vars)
      end
      vim.schedule_wrap(callback)()
    else
      print("run.sh does not exist in the directory.")
    end
  else
    print("Could not determine the current buffer's directory.")
  end
end

nnoremap("<leader>rn", main)
