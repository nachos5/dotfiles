local M = {}

local utils = require("run_script.utils")

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

-- TODO: don't have to save file/buffer.
M.get_env_vars = function()
  local buffer_path = utils.get_current_buffer_path()
  if not buffer_path then
    vim.api.nvim_err_writeln("Buffer has no file path.")
    return nil
  end

  -- Check if this is a json file.
  -- TODO: processor - allow to have custom processor.
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
  local buffer_dir = utils.get_directory(buffer_path)
  local dotenv_file = io.open(buffer_dir .. "/.env", "r")
  if dotenv_file then
    local dotenv_content = dotenv_file:read("*a")
    dotenv_file:close()
    local dotenv_lines = utils.get_lines(dotenv_content, true)
    local parsed_dotenv = parse_dotenv(dotenv_content)
    -- Replace placeholders in json file with env variables.
    json_content = replace_placeholders(json_content, parsed_dotenv)
    -- Append dotenv lines.
    vim.list_extend(lines, dotenv_lines)
  end

  -- Add json data env.
  -- Escape single quotes for shell: replace ' with '\''
  local escaped_json = json_content:gsub("'", "'\\''")
  table.insert(lines, "JSON_DATA='" .. escaped_json .. "'")

  local json_table = vim.json.decode(json_content)

  -- Join all lines with a space.
  return table.concat(lines, " "), json_table
end

return M
