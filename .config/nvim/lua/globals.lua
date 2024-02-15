vim.g.IS_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"
vim.g.IS_COLEMAK = vim.env.IS_COLEMAK ~= nil

vim.g.OS_HOME = vim.g.IS_WINDOWS and os.getenv("USERPROFILE") or os.getenv("HOME")
