return {
  "uga-rosa/translate.nvim",
  -- event = "VeryLazy",
  keys = {
    -- Normal mode: translate word under cursor.
    { "<leader>tle", "viw:Translate EN<CR>", mode = "n" },
    { "<leader>tli", "viw:Translate IS<CR>", mode = "n" },
    -- Visual mode: translate selected text.
    { "<leader>tle", ":Translate EN<CR>", mode = "v" },
    { "<leader>tli", ":Translate IS<CR>", mode = "v" },
  },
}
