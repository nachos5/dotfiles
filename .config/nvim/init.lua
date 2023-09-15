vim.cmd([[let &packpath = &runtimepath]])

IS_COLEMAK = vim.env.IS_COLEMAK ~= nil

require("set")
require("plugins")
require("mappings")
require("autocmds")
require("project")
