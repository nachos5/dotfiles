local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

vim.cmd([[
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <a-space> to trigger completion.
inoremap <silent><expr> <a-space> coc#refresh()
]])

nmap("gd", "<Plug>(coc-definition)", { silent = true })
nmap("gy", "<Plug>(coc-type-definition)", { silent = true })
nmap("gr", "<Plug>(coc-references)", { silent = true })

nmap("[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
nmap("]g", "<Plug>(coc-diagnostic-next)", { silent = true })

nmap("<leader>rn", "<Plug>(coc-rename)")

nnoremap("<space>d", ":<C-u>CocList diagnostics<cr>", { silent = true })

nmap("<leader>do", "<Plug>(coc-codeaction)")

nnoremap("<leader>cr", ":CocRestart<CR>")
nnoremap("<leader>co", ":CocCommand workspace.showOutput<CR>")

vim.cmd([[
autocmd FileType python,javascript,typescript,typescriptreact nnoremap <buffer> <localleader>f :call CocAction("format")<CR>
]])

-- You can add extension names to the g:coc_global_extensions variable, and coc
-- will install the missing extensions after coc.nvim service started.
--
-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#user-content-install-extensions
vim.g.coc_global_extensions = {
  "coc-docker",
  "coc-eslint",
  "coc-git",
  "coc-html",
  "coc-json",
  "coc-prettier",
  "coc-pyright",
  "coc-sh",
  "coc-tsserver",
  "coc-yaml",
  "https://github.com/VanceLongwill/import-sorter",
}
