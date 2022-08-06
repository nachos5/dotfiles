vim.cmd([[let &packpath = &runtimepath]])

require("set")
require("plugins")

-- Load custom tree-sitter grammar for org filetype
require("orgmode").setup_ts_grammar()

-- Tree-sitter configuration
require("nvim-treesitter.configs").setup({
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = { "org" }, -- Or run :TSUpdate org
})

require("orgmode").setup({
  org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
  org_default_notes_file = "~/Dropbox/org/refile.org",
})

require("mappings")

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

" python
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
function! FormatPython()
  call CocAction('runCommand', 'python.sortImports')
  call CocAction('format')
endfunction
" This triggers all formatting before coc linter is triggered
aug python
  au!
  autocmd BufWritePre *.py call FormatPython()
aug END

"
" typescript react
"
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2

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
