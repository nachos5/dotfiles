local Trailspace = {}

local function trim_first_lines(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local first_nonempty = 1
  while first_nonempty < #lines and lines[first_nonempty] == "" do
    first_nonempty = first_nonempty + 1
  end
  vim.api.nvim_buf_set_lines(buf, 0, first_nonempty - 1, false, {})
end

local function update_trailspace_disable(buf)
  local buf_options = vim.bo[buf]
  local is_markdown = buf_options.filetype == "markdown"
  vim.b[buf].minitrailspace_disable = is_markdown or nil
  local update_highlight = MiniTrailspace.unhighlight
  if not is_markdown and buf_options.buftype == "" and buf_options.modifiable then
    update_highlight = MiniTrailspace.highlight
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.api.nvim_win_call(win, update_highlight)
    end
  end
end

function Trailspace.setup()
  require("mini.trailspace").setup()

  local trailspace_group = vim.api.nvim_create_augroup("TrailspaceTrim", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = trailspace_group,
    pattern = "*",
    callback = function(args)
      update_trailspace_disable(args.buf)
    end,
  })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = trailspace_group,
    callback = function(args)
      local buf_options = vim.bo[args.buf]
      if buf_options.filetype == "markdown" or buf_options.buftype ~= "" or not buf_options.modifiable then
        return
      end

      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd("silent lua MiniTrailspace.trim()")
        MiniTrailspace.trim_last_lines()
        trim_first_lines(args.buf)
      end)
    end,
  })

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      update_trailspace_disable(buf)
    end
  end
end

return Trailspace
