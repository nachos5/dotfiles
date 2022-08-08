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

vim.cmd([[
filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

colorscheme gruvbox

" treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set termguicolors " this variable must be enabled for colors to be applied properly
" nerdcommenter
let NERDSpaceDelims=1

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic
]])
