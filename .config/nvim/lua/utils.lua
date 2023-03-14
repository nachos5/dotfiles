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

return M
