-- Condense visual selection into one line and reselect the result.
vim.keymap.set("x", "cd", function()
  -- Exit visual mode to update the marks.
  vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<Esc>", true, false, true))

  -- Get the start and end of visual selection.
  local start_line = vim.fn.line("'<") - 1
  local end_line = vim.fn.line("'>")
  print(start_line, end_line)

  -- Get selected lines.
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
  -- Join them with spaces, trimming whitespace.
  local joined = table.concat(
    vim.tbl_map(function(line)
      return vim.trim(line)
    end, lines),
    " "
  )

  -- Replace all selected lines with the joined content at the start position.
  vim.api.nvim_buf_set_lines(0, start_line, end_line, false, { joined })

  -- Reselect the new single line.
  vim.cmd("normal! V")
end, { noremap = true, silent = true })
