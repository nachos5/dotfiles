local M = {}

M.yank_all_entries = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager

  local entries = {}
  for entry in manager:iter() do
    local display, _ = entry_display.resolve(picker, entry)
    table.insert(entries, display)
  end

  local text = table.concat(entries, "\n")

  actions.close(prompt_bufnr)

  vim.fn.setreg("+", text)
end

M.yank_preview_lines = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local picker = action_state.get_current_picker(prompt_bufnr)
  local previewer = picker.previewer
  local winid = previewer.state.winid
  local bufnr = previewer.state.bufnr

  local line_start = vim.fn.line("w0", winid)
  local line_end = vim.fn.line("w$", winid)

  local lines = vim.api.nvim_buf_get_lines(bufnr, line_start, line_end, false)

  local text = table.concat(lines, "\n")

  actions.close(prompt_bufnr)

  vim.fn.setreg("+", text)
end

return M
