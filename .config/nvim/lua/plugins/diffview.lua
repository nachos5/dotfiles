return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>vo", ":DiffviewOpen<CR>", desc = "Open Diffview" },
    { "<leader>vc", ":DiffviewClose<CR>", desc = "Close Diffview" },
    { "<leader>vh", ":DiffviewFileHistory %<CR>", desc = "Current file history" },
    { "<leader>vm", ":DiffviewOpen master...HEAD<CR>", desc = "Diff against master" },
  },
}
