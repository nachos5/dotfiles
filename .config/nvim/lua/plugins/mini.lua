return {
  "nvim-mini/mini.nvim",
  version = false,
  lazy = false,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- ga=
    require("mini.align").setup()

    require("mini.ai").setup()

    require("mini.bufremove").setup()

    require("mini.comment").setup({
      options = {
        ignore_blank_line = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    -- gS
    require("mini.splitjoin").setup()

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

    require("mini.icons").setup({
      extension = {
        ["local"] = {
          glyph = "⚙️",
        },
        lock = {
          glyph = "",
        },
      },
    })
    MiniIcons.mock_nvim_web_devicons()

    require("mini.pairs").setup()
  end,
}
