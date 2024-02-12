vim.cmd([[
" highlight yanked text
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="Visual", timeout=200})
augroup END

" python
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
au BufRead,BufNewFile *.pyscript set filetype=python

" typescript react
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
]])
