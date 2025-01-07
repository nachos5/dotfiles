return {
  "smartpde/neoscopes",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    { "<leader>ss", "<cmd>lua require('neoscopes').select()<CR>" },
    { "<leader>sc", "<cmd>lua require('neoscopes').clear()<CR>" },
  },
}
