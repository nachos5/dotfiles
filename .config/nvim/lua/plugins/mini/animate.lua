local MiniAnimate = {}

local function scroll_window(key, select_mode)
  local count = math.max(1, math.floor(vim.api.nvim_win_get_height(0) * 0.1 + 0.5))
  local keys = count .. vim.keycode(key)
  if select_mode then
    keys = vim.keycode("<C-o>") .. keys
    vim.api.nvim_feedkeys(keys, "n", false)
    return
  end
  vim.cmd.normal({ args = { keys }, bang = true })
end

function MiniAnimate.setup()
  local animate = require("mini.animate")
  animate.setup({
    cursor = { enable = false },
    scroll = {
      timing = animate.gen_timing.linear({ duration = 120, unit = "total" }),
    },
    resize = { enable = false },
    open = { enable = false },
    close = { enable = false },
  })

  vim.keymap.set({ "n", "x" }, "<C-y>", function()
    scroll_window("<C-y>")
  end, { desc = "Scroll window up 10%" })
  vim.keymap.set("s", "<C-y>", function()
    scroll_window("<C-y>", true)
  end, { desc = "Scroll window up 10%" })
  vim.keymap.set({ "n", "x" }, "<C-e>", function()
    scroll_window("<C-e>")
  end, { desc = "Scroll window down 10%" })
  vim.keymap.set("s", "<C-e>", function()
    scroll_window("<C-e>", true)
  end, { desc = "Scroll window down 10%" })
end

return MiniAnimate
