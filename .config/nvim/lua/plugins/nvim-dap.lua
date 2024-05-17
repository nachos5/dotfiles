local dap = require("dap")
local ui = require("dapui")

ui.setup()
require("nvim-dap-virtual-text").setup({})

require("dap-python").setup() -- pip install debugby
require("dap-go").setup()

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<space>c", dap.continue)
vim.keymap.set("n", "<space>si", dap.step_into)
vim.keymap.set("n", "<space>so", dap.step_over)
vim.keymap.set("n", "<space>su", dap.step_out)
vim.keymap.set("n", "<space>sb", dap.step_back)
vim.keymap.set("n", "<space>r", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end
