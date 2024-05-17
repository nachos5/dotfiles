local Remap = require("keymap")
local nnoremap = Remap.nnoremap

local function insert_reveal_type()
  local word = vim.fn.expand("<cword>")
  local current_line_number = vim.api.nvim_win_get_cursor(0)[1]
  local current_line = vim.api.nvim_buf_get_lines(0, current_line_number - 1, current_line_number, false)[1]
  local indent = current_line:match("^%s*")
  local reveal_type = indent .. "reveal_type(" .. word .. ")"

  vim.api.nvim_buf_set_lines(0, current_line_number, current_line_number, false, { reveal_type })
end
nnoremap("<leader>rt", insert_reveal_type)

local function insert_python_breakpoint()
  local current_line_number = vim.api.nvim_win_get_cursor(0)[1]
  local current_line = vim.api.nvim_buf_get_lines(0, current_line_number - 1, current_line_number, false)[1]
  local indent = current_line:match("^%s*")
  local bp = indent .. "breakpoint()"

  vim.api.nvim_buf_set_lines(0, current_line_number + 1, current_line_number + 1, false, { bp })
end
nnoremap("<leader>pb", insert_python_breakpoint)
