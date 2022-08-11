vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true

vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showmode = true

vim.opt.list = true
vim.opt.listchars:append("tab:-->")
vim.opt.listchars:append("trail:~")

vim.opt.fillchars:append("vert:\\")

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.encoding = "utf-8"

vim.opt.textwidth = 0

vim.opt.hidden = true

vim.opt.number = true

vim.opt.title = true

vim.opt.clipboard:append("unnamedplus")

vim.opt.relativenumber = true

vim.g.mapleader = ","
vim.g.maplocalleader = " "
