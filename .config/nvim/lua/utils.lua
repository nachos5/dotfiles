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

function M.split_string_by_delimiter(input, delimiter)
  local result = {}
  for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

return M
