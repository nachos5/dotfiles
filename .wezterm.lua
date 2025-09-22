local wezterm = require("wezterm")

return {
  -- font
  -- https://www.nerdfonts.com/font-downloads
  font = wezterm.font("BlexMono Nerd Font"),
  font_size = 13,
  adjust_window_size_when_changing_font_size = false,

  -- colors
  color_scheme = "tokyonight",

  -- tabs
  enable_tab_bar = false,
  scrollback_lines = 1000, -- default 3500.

  -- windows
  window_decorations = "RESIZE",
  window_background_opacity = 0.90,
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },

  -- updates
  check_for_updates = false,
}
