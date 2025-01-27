local function pre_edit()
  if FLOATING_TERM:is_open() and TERM_LAST_FOCUSED_BUFFER ~= nil then
    FLOATING_TERM:close()
    vim.api.nvim_set_current_buf(TERM_LAST_FOCUSED_BUFFER)
  end
end

vim.keymap.set("n", "gf", function()
  -- local filepath = vim.fn.expand("<cfile>")
  local filepath = vim.fn.expand("<cWORD>")

  local prefixes = require("env").config.GF_PREFIXES_TO_CHECK
  -- Try original path first.
  if not vim.tbl_contains(prefixes, "") then
    table.insert(prefixes, 1, "")
  end

  -- First check if it's a path with line number (file.py:49:22 or file.py:49).
  local file_part, part = string.match(filepath, "([^:]+):(%d+)")
  local line_num = part
  if file_part and line_num then
    for _, prefix in ipairs(prefixes) do
      local path = prefix .. file_part
      if vim.fn.filereadable(path) == 1 then
        pre_edit()
        -- Open the file and go to specific line.
        vim.cmd("edit! " .. path)
        vim.cmd(":" .. line_num)
        vim.cmd("normal! zz_")
        return
      end
    end
  end

  -- Check if it's a Python test function path (contains ::).
  file_part, part = string.match(filepath, "(.+)::(.+)")
  local func_part = part
  if file_part then
    if func_part then
      -- Split by colon and take the first part.
      func_part = string.match(func_part, "([^:]+)") or func_part
      -- Then strip any pytest parameters in square brackets if present.
      func_part = string.match(func_part, "([^%[]+)") or func_part
    end

    for _, prefix in ipairs(prefixes) do
      local path = prefix .. file_part
      if vim.fn.filereadable(path) == 1 then
        pre_edit()
        -- Open file and search for function in a single command
        vim.cmd("edit +/def\\ " .. func_part .. " " .. path)
        vim.cmd("normal! zz_")
        return
      end
    end
  else
    -- Handle regular file paths.
    for _, prefix in ipairs(prefixes) do
      local path = prefix .. filepath
      if vim.fn.filereadable(path) == 1 then
        pre_edit()
        vim.cmd("edit " .. path)
        return
      end
    end
  end

  -- If still not found, show a notification.
  vim.notify("File not found: " .. filepath, vim.log.levels.WARN)
end, { noremap = true, silent = true })
