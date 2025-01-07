local scopes = require("neoscopes")

local M = {}
local state = {
  ignore_scopes = false,
}

scopes.setup({
  on_scope_selected = function(scope)
    if state.ignore_scopes then
      state.ignore_scopes = false
    end
  end,
})

---@return Scope|nil current_scope
function M.get_current_scope()
  if state.ignore_scopes then
    return nil
  else
    return scopes.get_current_scope()
  end
end

---@return string[]|nil dirs
function M.get_scope_dirs()
  local dirs = nil
  if scopes.get_current_scope() then
    dirs = scopes.get_current_dirs()
  end

  return dirs
end

function M.toggle_ignore_scopes()
  state.ignore_scopes = not state.ignore_scopes
end

return M
