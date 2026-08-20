return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>vo", ":DiffviewOpen<CR>", desc = "Open Diffview" },
    { "<leader>vc", ":DiffviewClose<CR>", desc = "Close Diffview" },
    { "<leader>vh", ":DiffviewFileHistory %<CR>", desc = "Current file history" },
    { "<leader>vm", ":DiffviewOpen master...HEAD<CR>", desc = "Diff against master" },
    {
      "<leader>vM",
      function()
        local merge_base = vim.trim(vim.fn.system("git merge-base master HEAD"))
        if vim.v.shell_error ~= 0 then
          vim.notify("git merge-base failed: " .. merge_base, vim.log.levels.ERROR)
          return
        end
        vim.cmd("DiffviewOpen " .. merge_base)
      end,
      desc = "Diff against master incl. working changes",
    },
  },
  opts = {
    default_args = {
      -- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md
      DiffviewOpen = { "--imply-local" },
    },
  },
}
