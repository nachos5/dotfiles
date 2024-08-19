local ts_utils = require("nvim-treesitter.ts_utils")
local treesitter = require("vim.treesitter")

local M = {}

function M.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

function M.starts_with(str, start)
  return str:sub(1, #start) == start
end

function M.file_contains(file, pattern)
  local f = io.open(file, "r")
  if f == nil then
    return false
  end
  local content = f:read("*all")
  f:close()
  return content:match(pattern) ~= nil
end

function M.get_relative_path(absolute_path)
  return vim.fn.substitute(absolute_path, vim.fn.getcwd() .. "/", "", "")
end

function M.get_filename_from_path(path)
  local split = vim.split(path, "/")
  return split[#split]
end

function M.edit_file(filename, line_number)
  local edit_cmd = string.format(":e %s", filename)
  if line_number ~= nil then
    edit_cmd = string.format(":e +%d %s", line_number, filename)
  end
  vim.cmd(edit_cmd)
end

function M.get_current_cursor_function_name()
  local current_node = ts_utils.get_node_at_cursor()

  if not current_node then
    return ""
  end

  local expr = current_node

  -- Traverse up the tree until we find the first function definition (if any).
  while expr do
    local expr_type = expr:type()
    if expr_type == "function_definition" then
      break
    end
    expr = expr:parent()
  end

  if not expr then
    return ""
  end

  local function_name_node = expr:named_child(0)

  return treesitter.get_node_text(function_name_node, 0)
end

function M.get_current_buffer_filename()
  return vim.api.nvim_buf_get_name(0)
end

function M.merge_tables(first_table, second_table)
  if second_table == nil then
    return first_table
  end

  return vim.tbl_extend("force", first_table, second_table)
end

function M.os_home_path(path)
  if vim.g.IS_WINDOWS then
    path = string.gsub(path, "/", "\\")
  end

  return vim.g.OS_HOME .. path
end


return M
