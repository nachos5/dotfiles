local M = {}

function M.get_scope_dirs()
  local scopes = require("neoscopes")
  local dirs = nil
  if scopes.get_current_scope() then
    dirs = scopes.get_current_dirs()
  end

  return dirs
end

return M
