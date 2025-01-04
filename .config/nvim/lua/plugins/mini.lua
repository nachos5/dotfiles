return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- ga=
    require("mini.align").setup()

    require("mini.ai").setup()

    require("mini.bufremove").setup()

    require("mini.surround").setup({
      mappings = {
        add = "ss", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    })

    -- gS
    require("mini.splitjoin").setup()
  end,
}
