local ok_treesitter, treesitter = pcall(require, "vim.treesitter")

local M = {}

---@param o any
---@return string
function M.dump(o)
  if type(o) == "table" then
    local s = "{\n"
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      local value = v == nil and "nil" or M.dump(v)
      s = s .. "  [" .. k .. "] = " .. value .. ",\n"
    end
    return s .. "}"
  else
    if type(o) == "string" then
      return '"' .. tostring(o) .. '"'
    else
      return tostring(o)
    end
  end
end

---@param str string
---@param start string
---@return boolean
function M.starts_with(str, start)
  return str:sub(1, #start) == start
end

---@param file string
---@param pattern string
---@return boolean
function M.file_contains(file, pattern)
  local f = io.open(file, "r")
  if f == nil then
    return false
  end
  local content = f:read("*all")
  f:close()
  return content:match(pattern) ~= nil
end

---@param absolute_path string
---@return string
function M.get_relative_path(absolute_path)
  return vim.fn.substitute(absolute_path, vim.fn.getcwd() .. "/", "", "")
end

---@param path string
---@return string
function M.get_filename_from_path(path)
  local split = vim.split(path, "/")
  return split[#split]
end

---@param filename string
---@param line_number integer|nil
---@return nil
function M.edit_file(filename, line_number)
  if FLOATING_TERM:is_open() and TERM_LAST_FOCUSED_BUFFER ~= nil then
    FLOATING_TERM:close()
    vim.api.nvim_set_current_buf(TERM_LAST_FOCUSED_BUFFER)
  end

  vim.schedule(function()
    local edit_cmd = string.format(":e %s", filename)
    if line_number ~= nil then
      edit_cmd = string.format(":e +%d %s", line_number, filename)
    end
    vim.cmd(edit_cmd)
  end)
end

---@return TSNode|nil
function M.get_node_at_cursor()
  if not ok_treesitter then
    return nil
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  if not ft or ft == "" then
    return nil
  end

  local ok_parser, parser = pcall(treesitter.get_parser, bufnr, ft)
  if not ok_parser or not parser then
    return nil
  end

  local tree = parser:parse()[1]
  if not tree then
    return nil
  end

  local root = tree:root()
  if not root then
    return nil
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  return root:named_descendant_for_range(row, col, row, col)
end

---@return string
function M.get_current_cursor_function_name()
  if not ok_treesitter then
    return ""
  end

  local node = M.get_node_at_cursor()
  if not node then
    return ""
  end

  -- Walk up until we hit a (python) function node
  while node and node:type() ~= "function_definition" do
    node = node:parent()
  end

  if not node then
    return ""
  end

  -- Stable: fetch the field "name" (don’t assume named_child(0))
  local name_node = node:field("name")[1]
  if not name_node then
    return ""
  end

  return treesitter.get_node_text(name_node, 0) or ""
end

---@return string
function M.get_current_buffer_filename()
  return vim.api.nvim_buf_get_name(0)
end

function M.merge_tables(first_table, second_table)
  if second_table == nil then
    return first_table
  end

  return vim.tbl_extend("force", first_table, second_table)
end

---@param path string
---@return string
function M.os_home_path(path)
  if vim.g.IS_WINDOWS then
    path = string.gsub(path, "/", "\\")
  end

  return vim.g.OS_HOME .. path
end

return M
