return {
  "tris203/precognition.nvim",
  keys = {
    {
      "<leader>pc",
      function()
        require("precognition").toggle()
      end,
      desc = "Toggle Precognition",
    },
  },
}
