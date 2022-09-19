require("tokyonight").setup({
  style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  transparent = true,
  terminal_colors = false,
  sidebars = {
    "qf",
    "vista_kind",
    "packer",
    "terminal",
    "toggleterm",
  },
  styles = {
    sidebars = "transparent",
    floats = "dark",
  },
})
