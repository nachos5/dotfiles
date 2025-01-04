return {
  "mattn/emmet-vim",
  event = "InsertEnter",
  ft = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  config = function()
    vim.g.user_emmet_mode = "inv"
    vim.g.user_emmet_leader_key = "<C-m>"
  end,
}
