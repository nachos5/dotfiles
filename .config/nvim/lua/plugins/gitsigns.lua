---@param bufnr integer|nil
local function attach(bufnr)
  local gitsigns = require("gitsigns")

  if bufnr == nil then
    bufnr = vim.api.nvim_get_current_buf()
  end

  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- hunk navigation
  map("n", "]h", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })
  map("n", "[h", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true })

  -- other hunk actions
  map("n", "<leader>hp", ":Gitsigns preview_hunk_inline<CR>")
  map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")

  -- blame
  map("n", "<leader>gb", gitsigns.blame)
end

return {
  "lewis6991/gitsigns.nvim",
  attach = attach,
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
      on_attach = function(bufnr)
        attach(bufnr)
      end,
    })
  end,
}
