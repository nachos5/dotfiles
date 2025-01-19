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
  init = function()
    -- === DB UI === --
    vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
    vim.g.db_ui_auto_execute_table_helpers = true
    vim.g.db_ui_enable_query_history = true
    vim.g.db_ui_show_database_icon = true
    vim.g.db_ui_use_nerd_fonts = true
    vim.g.db_ui_use_nvim_notify = true
    vim.g.db_ui_execute_on_save = false

    vim.g.db_ui_table_helpers = {
      postgresql = {
        Count = "SELECT count(*) FROM {table}",
      },
    }
  end,
  config = function()
    local function db_completion()
      require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
    end

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
