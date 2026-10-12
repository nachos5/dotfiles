local MiniAnimate = {}

local skip_next_scroll = false

-- Jump instantly for motions that should not animate.
local function instant_motion(key)
  return function()
    skip_next_scroll = true
    -- Clear the flag if the motion does not scroll, so the next real scroll still animates.
    vim.schedule(function()
      skip_next_scroll = false
    end)
    return key
  end
end

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
  local mouse_scroll_lines = math.max(1, tonumber(vim.o.mousescroll:match("ver:(%d+)")) or 3)
  animate.setup({
    cursor = { enable = false },
    scroll = {
      timing = animate.gen_timing.linear({ duration = 120, unit = "total" }),
      -- mini.animate cannot identify the scroll source, so skip mouse-sized changes to avoid wheel jitter.
      subscroll = animate.gen_subscroll.equal({
        predicate = function(total_scroll)
          if skip_next_scroll then
            skip_next_scroll = false
            return false
          end
          return math.abs(total_scroll) > mouse_scroll_lines
        end,
      }),
    },
    resize = { enable = false },
    open = { enable = false },
    close = { enable = false },
  })

  for _, key in ipairs({ "G", "gg" }) do
    vim.keymap.set(
      { "n", "x" },
      key,
      instant_motion(key),
      { expr = true, desc = "Jump to " .. key .. " without animation" }
    )
  end

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
