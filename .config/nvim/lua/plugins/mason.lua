require("mason").setup()
mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "eslint",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "tailwindcss",
    "tsserver",
    "yamlls",
  },
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("Couldn't load LSP-Config" .. lspconfig, "error")
  return
end

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = require("lsp").on_attach,
    })
  end,

  ["pyright"] = function()
    lspconfig.pyright.setup({
      on_attach = require("lsp").on_attach,

      settings = {
        python = {
          analysis = {
            -- Disable strict type checking
            typeCheckingMode = "off",
          },
        },
      },
    })
  end,
})
