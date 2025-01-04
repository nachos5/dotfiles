return {
  "pwntester/octo.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nnoremap = require("keymap").nnoremap

    -- https://github.com/pwntester/octo.nvim#-pr-review

    require("octo").setup()

    local default_opts = { noremap = true, silent = true }

    nnoremap("<leader>opl", ":Octo pr list<CR>", default_opts)
    nnoremap("<leader>opc", ":Octo pr changes<CR>", default_opts)
    nnoremap("<leader>opd", ":Octo pr diff<CR>", default_opts)
    nnoremap("<leader>oa", ":Octo actions<CR>", default_opts)
  end,
}
