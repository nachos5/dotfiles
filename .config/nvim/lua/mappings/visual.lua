local function _select_markdown_block()
  -- Save current position
  local pos = vim.api.nvim_win_get_cursor(0)

  -- Find start of code block content
  local found = vim.fn.search("```.*\\n\\zs", "bcW")
  if found == 0 then
    vim.api.nvim_win_set_cursor(0, pos) -- restore position
    return false
  end

  -- Start visual line selection
  vim.cmd("normal! V")

  -- Extend to end of code block
  vim.fn.search("\\ze\\n```", "W")

  return true
end

vim.keymap.set("n", "<leader>mv", _select_markdown_block, { noremap = true, silent = true })
