-- OS.
vim.g.IS_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"
vim.g.OS_HOME = vim.g.IS_WINDOWS and os.getenv("USERPROFILE") or os.getenv("HOME")
