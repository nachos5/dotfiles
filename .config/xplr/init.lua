version = "0.21.1"

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

-- https://xplr.dev/en/general-config
xplr.config.general.show_hidden = true

-- https://github.com/sayanarijit/fzf.xplr
require("fzf").setup({
  mode = "default",
  key = "ctrl-f",
})

-- https://github.com/sayanarijit/preview-tabbed.xplr
require("preview-tabbed").setup({
  mode = "action",
  key = "P",
  fifo_path = "/tmp/xplr.fifo",
  previewer = os.getenv("HOME") .. "/.config/nnn/plugins/preview-tabbed",
}) -- Type `:p` to toggle preview mode.
