local Path = require("plenary.path")

local M = {}

M.get_current_buffer_path = function()
  -- Get the full path of the current buffer.
  local buffer_path = vim.fn.expand("%:p")

  -- If the buffer has no associated file, handle accordingly.
  if buffer_path == "" then
    vim.api.nvim_err_writeln("Buffer has no file path.")
    return nil
  end

  return buffer_path
end

M.get_directory = function(filepath)
  -- Create a Path object and get the parent directory.
  local directory = Path:new(filepath):parent()

  -- Convert the Path object to a string to return the directory path.
  return tostring(directory)
end

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
