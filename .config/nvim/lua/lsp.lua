local export = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- keymaps commented out are moved to lspsaga

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts)
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
-- vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)

local diagnostic_config = {
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
  },
  virtual_text = {
    spacing = 5,
    severity_limit = "Warning",
  },
  underline = true,
  update_in_insert = false,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config)
vim.diagnostic.config(diagnostic_config)

function export.on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>t", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
      end,
    })
  end

  require("lsp_signature").on_attach({
    hint_enable = false,
  }, bufnr)
end

return export
