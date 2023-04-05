version = "0.21.1"

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

-- https://github.com/sayanarijit/fzf.xplr
require("fzf").setup({
  mode = "default",
  key = "ctrl-f",
})
