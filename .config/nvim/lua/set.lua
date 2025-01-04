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
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.showcmd = true
vim.opt.showmode = true

vim.opt.list = true
vim.opt.listchars:append("tab:-->")
vim.opt.listchars:append("trail:~")

vim.opt.fillchars:append("vert:\\")

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.encoding = "utf-8"

vim.opt.textwidth = 0

vim.opt.hidden = true

vim.opt.number = true

vim.opt.title = true

vim.opt.fileformat = "unix"

-- try to install xclip if not working
vim.opt.clipboard:append("unnamedplus")

vim.opt.relativenumber = true

-- default is 1000 (1 sec)
vim.opt.timeoutlen = 1500

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

vim.g.mapleader = ","
vim.g.maplocalleader = " "


local function get_python_path()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    return venv .. "/bin/python"
  else
    return "/opt/python/3.11.2/bin/python3.11"
  end
end

vim.g.python3_host_prog = get_python_path()

vim.lsp.set_log_level("ERROR")
