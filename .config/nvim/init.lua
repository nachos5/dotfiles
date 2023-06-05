vim.cmd([[let &packpath = &runtimepath]])

IS_COLEMAK = vim.env.IS_COLEMAK ~= nil

require("set")
require("plugins")
require("mappings")
require("autocmds")

function add_buffer_lines_to_quickfix_list()
  local bufnr = vim.api.nvim_get_current_buf() -- Get the current buffer number
  local filenames = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) -- Get all lines in the current buffer
  local cwd = vim.fn.getcwd() -- Get the current working directory

  local qflist = {} -- Initialize an empty quickfix list
  local added = {} -- Initialize an empty set for keeping track of added filenames

  for _, filename in ipairs(filenames) do
    local full_path = cwd .. "/" .. filename -- Join the filename with the current working directory
    if filename ~= "" and not added[filename] and vim.loop.fs_stat(full_path) then -- If the filename is not empty and has not been added yet...
      table.insert(qflist, { filename = full_path, lnum = 1, col = 1, text = "" })
      added[filename] = true -- Mark the filename as added
    end
  end

  vim.fn.setqflist(qflist) -- Set the quickfix list
end
