require("toggleterm").setup({
  size = 15,
  open_mapping = [[<leader><C-t>]],
})
local Terminal = require("toggleterm.terminal").Terminal

-- <C-f> for a floating terminal
local floating = Terminal:new({ direction = "float", hidden = true })
function _floating_toggle()
  floating:toggle()
end
vim.api.nvim_set_keymap("n", "<leader><C-f>", "<cmd>lua _floating_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader><C-f>", "<cmd>lua _floating_toggle()<CR>", { noremap = true, silent = true })

-- <C-g> for a lazygit floating terminal
local lg_cmd = "lazygit $(pwd)"
if vim.v.servername ~= nil then
  lg_cmd = string.format("NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml $(pwd)", vim.v.servername)
end

local lazygit = Terminal:new({ cmd = lg_cmd, direction = "float", hidden = true })
function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

-- for editing back from LazyGit (lazygit.toml)
function _edit(fn, line_number)
  local edit_cmd = string.format(":e %s", fn)
  if line_number ~= nil then
    edit_cmd = string.format(":e +%d %s", line_number, fn)
  end
  vim.cmd(edit_cmd)
end
