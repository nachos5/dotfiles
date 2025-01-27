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

vim.keymap.set("n", "<leader>cy", function()
  local filename = vim.fn.expand("%:p") -- Full path.
  local relative = vim.fn.expand("%") -- Relative path.
  local just_name = vim.fn.expand("%:t") -- Just filename.
  local dir_path = vim.fn.expand("%:p:h") -- Full directory path.
  local relative_dir_path = vim.fn.expand("%:h") -- Relative directory path.

  local options = {
    ["1"] = { name = "Full path", value = filename },
    ["2"] = { name = "Relative path", value = relative },
    ["3"] = { name = "Filename only", value = just_name },
    ["4"] = { name = "Full directory path", value = dir_path },
    ["5"] = { name = "Relative directory path", value = relative_dir_path },
  }

  local items = {}
  for _, option in pairs(options) do
    table.insert(items, string.format("%s: %s", option.name, option.value))
  end

  vim.ui.select(items, {
    prompt = "Choose what to copy:",
  }, function(choice)
    if choice then
      -- Extract the part after the colon.
      local value = choice:match(": (.+)$")
      vim.fn.setreg("+", value)
      vim.notify("Copied: " .. value)
    end
  end)
end, { noremap = true, desc = "Copy file path menu" })
