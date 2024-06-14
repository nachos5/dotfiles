version = "0.21.5"

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

-- https://xplr.dev/en/general-config
xplr.config.general.show_hidden = true

-- https://github.com/sayanarijit/fzf.xplr
require("fzf").setup({
  mode = "default",
  key = "ctrl-f",
  recursive = true,
})

-- https://github.com/sayanarijit/preview-tabbed.xplr
require("preview-tabbed").setup({
  mode = "action",
  key = "P",
  fifo_path = "/tmp/xplr.fifo",
  previewer = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
}) -- Type `:p` to toggle preview mode.

require("nvim-ctrl").setup({
  bin = "nvim-ctrl",
  mode = "default",
  keys = {
    ["ctrl-e"] = "tabedit",
    ["e"] = "e",
  },
})

-- Type `yy` to copy and `p` to paste whole files.
-- Type `yp` to copy the paths of focused or selected files.
-- Type `yP` to copy the parent directory path.
require("xclip").setup({
  copy_command = "xclip-copyfile",
  copy_paths_command = "xclip -sel clip",
  paste_command = "xclip-pastefile",
  keep_selection = false,
})

xplr.config.general.initial_sorting = {
  { sorter = "ByCanonicalIsDir", reverse = true },
  { sorter = "ByCanonicalLastModified", reverse = true },
}
