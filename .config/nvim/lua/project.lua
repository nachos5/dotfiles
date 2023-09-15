-- Check for project specific configuration.
if PROJECT_CONFIG_OK == nil then
  PROJECT_CONFIG_OK, PROJECT_CONFIG = pcall(dofile, vim.fn.getcwd() .. "/.project.lua")
end
