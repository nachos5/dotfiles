local trouble = require("trouble")
local wk = require("which-key")

local function _set_keymaps()
  wk.register({
    x = {
      name = "Trouble",
      x = { "<cmd>Trouble diagnostics toggle<cr>", "toggle" },
      d = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "document_diagnostics" },
      r = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP references" },
    },
  }, {
    prefix = "<leader>",
  })
end

trouble.setup()
_set_keymaps()
