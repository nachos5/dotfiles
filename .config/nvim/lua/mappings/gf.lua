local function pre_edit()
  if FLOATING_TERM:is_open() and TERM_LAST_FOCUSED_BUFFER ~= nil then
    FLOATING_TERM:close()
    vim.api.nvim_set_current_buf(TERM_LAST_FOCUSED_BUFFER)
  end
end

local function gf(opts)
  opts = opts or { vsplit = false }
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
        vim.cmd(opts.vsplit and "vsplit! " .. path or "edit! " .. path)
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
        vim.cmd(
          opts.vsplit and "vsplit +/def\\ " .. func_part .. " " .. path or "edit +/def\\ " .. func_part .. " " .. path
        )
        vim.cmd("normal! zz_")
        return
      end
    end
  else
    -- Handle regular file paths.
    local filepath_cfile = vim.fn.expand("<cfile>")
    for _, prefix in ipairs(prefixes) do
      local path = prefix .. filepath_cfile
      if vim.fn.filereadable(path) == 1 then
        pre_edit()
        vim.cmd(opts.vsplit and "vsplit " .. path or "edit " .. path)
        return
      end
    end
  end

  -- If still not found, show a notification.
  vim.notify("File not found: " .. filepath, vim.log.levels.WARN)
end

vim.keymap.set("n", "gf", function()
  gf()
end, { noremap = true, silent = true, desc = "Go to file" })
vim.keymap.set("n", "gF", function()
  gf({ vsplit = true })
end, { noremap = true, silent = true, desc = "Go to file in a vertical split" })
