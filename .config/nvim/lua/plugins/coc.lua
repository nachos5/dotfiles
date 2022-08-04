local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

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
