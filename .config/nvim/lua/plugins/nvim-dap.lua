local dap = require("dap")
local ui = require("dapui")

-- :help dap-configurations

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
vim.keymap.set("n", "<space>sd", dap.disconnect)
vim.keymap.set("n", "<space>r", dap.restart)

-- Attach remote.
local python_attach_remote_config = {
  type = "python",
  request = "attach",
  name = "Attach Remote (localhost:5678)",
  connect = {
    host = "localhost",
    port = 5678,
  },
}

local remote_root = vim.env.DAP_REMOTE_ROOT
if remote_root then
  python_attach_remote_config.pathMappings = {
    {
      localRoot = vim.fn.getcwd(),
      remoteRoot = remote_root,
    },
  }
end
vim.keymap.set("n", "<space>ar", function()
  dap.run(python_attach_remote_config)
end)

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
