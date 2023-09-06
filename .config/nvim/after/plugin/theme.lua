vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_invert_selection = "0"
vim.opt.background = "dark"

vim.cmd([[
filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

" colorscheme gruvbox
colorscheme tokyonight

" nerdcommenter
let NERDSpaceDelims=1

" notifications
hi NotificationInfo guifg=#c0caf5
hi NotificationInfo guifg=#555555 guibg=#02d6d9

" TSX
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

" Octo
hi OctoEditable guibg=#222222 cterm=italic

" Mind
highlight! link MindModifierEmpty String

]])
