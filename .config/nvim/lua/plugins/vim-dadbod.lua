return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  keys = {
    { "<leader>du", ":DBUIToggle<CR>", desc = "Toggle DB UI" },
    { "<leader>df", ":DBUIFindBuffer<CR>", desc = "Find DB buffer" },
    { "<leader>dr", ":DBUIRenameBuffer<CR>", desc = "Rename DB buffer" },
    { "<leader>dl", ":DBUILastQueryInfo<CR>", desc = "Show last query info" },
  },
  config = function()
    local function db_completion()
      require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    end

    -- Set save location for DB UI
    vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

    -- Setup SQL completion
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "sql",
      },
      command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
    })

    -- Setup DB completion for SQL file types
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
  end,
}
