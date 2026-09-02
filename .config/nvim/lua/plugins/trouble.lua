return {
  "folke/trouble.nvim",
  config = function()
    local trouble = require("trouble")

    trouble.setup()
    vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {
      desc = "Document diagnostics",
    })
    vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {
      desc = "LSP references",
    })
    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle diagnostics" })
  end,
}
