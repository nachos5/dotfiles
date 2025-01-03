return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local trouble = require("trouble")
    local wk = require("which-key")

    local function _set_keymaps()
      wk.add({
        { "<leader>x", group = "Trouble" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "document_diagnostics" },
        { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "toggle" },
      })
    end

    trouble.setup()
    _set_keymaps()
  end,
}
