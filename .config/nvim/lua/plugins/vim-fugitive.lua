local nnoremap = require("keymap").nnoremap

local shared_opts = { silent = true }

nnoremap("<leader>gs", ":Git<CR>", shared_opts)
nnoremap("<leader>gll", ":Gclog<cr>", shared_opts)
-- % is current buffer, # current branch
nnoremap("<leader>glb", ":Gclog %<cr>", shared_opts)
nnoremap("<leader>glm", ":Gclog master..# --<cr>", shared_opts)
nnoremap("<leader>gc", ":Git commit<cr>", shared_opts)
nnoremap("<leader>ga", ":Git add %<cr>", shared_opts)
nnoremap("<leader>gd", ":Gvdiffsplit!<CR>", shared_opts)
nnoremap("<leader>gm", ":Gvdiffsplit master<CR>", shared_opts)
nnoremap("<leader>gb", ":Git blame<CR>", shared_opts)
nnoremap("<leader>gt", ":Git mergetool<CR>", shared_opts)
nnoremap("<leader>gr", ":GBrowse<CR>", shared_opts)
nnoremap("<leader>gp", ":Git push<CR>", shared_opts)
nnoremap("<leader>gf", ":Git fetch<CR>", shared_opts)

-- get from left
nnoremap("<leader>g<left>", ":diffget //2<cr>", shared_opts)
-- get from right
nnoremap("<leader>g<right>", ":diffget //3<cr>", shared_opts)

nnoremap("<leader>geh", ":Gedit<CR>", shared_opts)
nnoremap("<leader>ge1", ":Gedit HEAD~1:%<CR>", shared_opts)
nnoremap("<leader>ge2", ":Gedit HEAD~2:%<CR>", shared_opts)
nnoremap("<leader>ge3", ":Gedit HEAD~3:%<CR>", shared_opts)
