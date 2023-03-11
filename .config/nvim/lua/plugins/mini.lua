-- ga=
require("mini.align").setup()

require("mini.ai").setup()

require("mini.bufremove").setup()

require("mini.surround").setup({
  mappings = {
    add = "ys", -- Add surrounding in Normal and Visual modes
    delete = "yd", -- Delete surrounding
    find = "yf", -- Find surrounding (to the right)
    find_left = "yF", -- Find surrounding (to the left)
    highlight = "yh", -- Highlight surrounding
    replace = "yr", -- Replace surrounding
    update_n_lines = "yn", -- Update `n_lines`

    suffix_last = "l", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },
})

-- gS
require("mini.splitjoin").setup()
