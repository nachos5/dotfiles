return {
  "folke/tokyonight.nvim",
  config = function()
    require("tokyonight").setup({
      style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = true,
      terminal_colors = false,
      styles = {
        sidebars = "transparent",
        floats = "dark",
      },
      sidebars = {
        "qf",
        "vista_kind",
        "terminal",
        "toggleterm",
      },
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When true, section headers in the lualine theme will be bold
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style
      cache = true, -- Enable theme cache to improve performance
      plugins = {},
      on_colors = function(colors)
        -- Add any color overrides here
      end,
      on_highlights = function(highlights, colors)
        -- Make buffer separators more visible
        highlights.WinSeparator = {
          fg = colors.bg_highlight,
          bold = false,
          italic = false,
          nocombine = true,
        }
      end,
    })
  end,
}
