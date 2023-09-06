local nnoremap = require("keymap").nnoremap

local M = {}

local function db_completion()
  require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

function M.setup()
  vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })

  local opts = { silent = true, noremap = true }

  nnoremap("<leader>du", ":DBUIToggle<CR>", opts)
  nnoremap("<leader>df", ":DBUIFindBuffer<CR>", opts)
  nnoremap("<leader>dr", ":DBUIRenameBuffer<CR>", opts)
  nnoremap("<leader>dl", ":DBUILastQueryInfo<CR>", opts)
end

return M
