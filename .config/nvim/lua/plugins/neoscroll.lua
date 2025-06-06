return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")
    neoscroll.setup()

    local keymap = {
      ["<C-u>"] = function()
        neoscroll.ctrl_u({ duration = 120 })
      end,
      ["<C-d>"] = function()
        neoscroll.ctrl_d({ duration = 120 })
      end,
      ["<C-b>"] = function()
        neoscroll.ctrl_b({ duration = 450 })
      end,
      ["<C-f>"] = function()
        neoscroll.ctrl_f({ duration = 450 })
      end,
      ["<C-y>"] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
      end,
      ["<C-e>"] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
      end,
      ["zt"] = function()
        neoscroll.zt({ half_win_duration = 120 })
      end,
      ["zz"] = function()
        neoscroll.zz({ half_win_duration = 120 })
      end,
      ["zb"] = function()
        neoscroll.zb({ half_win_duration = 120 })
      end,
    }
    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
