local Remap = require("keymap")
local nnoremap = Remap.nnoremap

local export = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Remove unwanted default keymaps.
local version = vim.version()
if version.minor > 10 then
  vim.keymap.del("n", "grn")
  vim.keymap.del("n", "gra")
  vim.keymap.del("n", "grr")
end

local diagnostic_config = {
  float = {
    show_header = true,
    source = "always",
    border = "rounded",
    focusable = false,
  },
  virtual_text = {
    spacing = 5,
  },
  underline = true,
  update_in_insert = false,
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, silent = true, desc = "Restart LSP" })
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ float = diagnostic_config.float })
end, opts)
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ float = diagnostic_config.float })
end, opts)

-- Set up diagnostic configuration
vim.diagnostic.config(diagnostic_config)

-- Set up diagnostic handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = diagnostic_config.virtual_text,
  signs = true,
  underline = diagnostic_config.underline,
  update_in_insert = diagnostic_config.update_in_insert,
})

function export.on_attach(client, bufnr, enable_formatting)
  if enable_formatting == nil then
    -- formatting off by default - use null-ls for all formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<space>k", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>t", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ bufnr = 0, timeout_ms = 10000, async = true })
  end, bufopts)

  if not require("env").config.DISABLE_FORMAT_ON_SAVE then
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
  end
end

local function stop_lsp_for_current_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = current_buf })

  for _, client in ipairs(clients) do
    vim.lsp.buf_detach_client(current_buf, client.id)
  end
end

local function enable_formatting_for_current_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = current_buf })

  for _, client in ipairs(clients) do
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  end
end

nnoremap("<leader>li", ":LspInfo<CR>", { silent = true, desc = "LSP Info" })
nnoremap("<leader>ls", stop_lsp_for_current_buffer, { silent = true, desc = "Stop LSP for buffer" })
nnoremap("<leader>lf", enable_formatting_for_current_buffer, { silent = true, desc = "Enable LSP formatting" })

return export
