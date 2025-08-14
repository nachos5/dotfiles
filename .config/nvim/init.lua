vim.cmd([[let &packpath = &runtimepath]])

require("globals")
require("set")
require("plugins")
require("mappings")
require("autocmds")
require("project")
require("run_script")

-- https://github.com/neovim/neovim/issues/34731
local util = require("vim.lsp.util")
local original_apply_text_edits = util.apply_text_edits
util.apply_text_edits = function(text_edits, bufnr, position_encoding, change_annotations)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  local is_pyright = false
  for _, client in ipairs(clients) do
    if client.name == "pyright" then
      is_pyright = true
    end
  end

  for _, edit in ipairs(text_edits or {}) do
    if is_pyright and edit.annotationId then
      edit.annotationId = nil
    end
  end

  return original_apply_text_edits(text_edits, bufnr, position_encoding, change_annotations)
end
