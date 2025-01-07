local Path = require("plenary.path")

local M = {}

--- Get the full path of the current buffer.
---@return string|nil buffer_path The full path or nil if no file is associated.
M.get_current_buffer_path = function()
  local buffer_path = vim.fn.expand("%:p")

  if buffer_path == "" then
    vim.api.nvim_err_writeln("Buffer has no file path.")
    return nil
  end

  return buffer_path
end

--- Get the parent directory of a filepath.
--- @param filepath string The file path to get the directory from.
--- @return string|nil directory The parent directory path or nil if invalid.
M.get_directory = function(filepath)
  local ok, directory = pcall(function()
    return Path:new(filepath):parent()
  end)

  if not ok then
    vim.api.nvim_err_writeln("Failed to get directory from filepath: " .. filepath)
    return nil
  end

  return tostring(directory)
end

--- Split a content string into a list of lines.
--- @param content string The content to split.
--- @param should_trim boolean Whether to trim leading and trailing whitespace from each line.
---@return string[] lines The processed list of lines.
M.get_lines = function(content, should_trim)
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

return M
