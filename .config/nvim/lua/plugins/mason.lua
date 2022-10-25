require("mason").setup()
mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "eslint",
    "graphql",
    "html",
    "jsonls",
    "phpactor",
    "pyright",
    "rust_analyzer",
    -- "sumneko_lua",
    -- "tailwindcss",
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
    if server_name == "tsserver" or server_name == "rust_analyzer" then
      return
    end
    require("lspconfig")[server_name].setup({
      on_attach = function(client, bufnr)
        -- use null-ls for all formatting
        client.server_capabilities.document_formatting = false
        require("lsp").on_attach(client, bufnr)
      end,
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

  -- ["tsserver"] = function()
  --   lspconfig.tsserver.setup({
  --     on_attach = function(client, bufnr)
  --       -- formatting is done with null-ls (prettier)
  --       client.server_capabilities.documentFormattingProvider = false
  --       client.server_capabilities.documentRangeFormattingProvider = false
  --       client.server_capabilities.document_formatting = false
  --       require("lsp").on_attach(client, bufnr)
  --     end,
  --   })
  -- end,
})

-- typescript setup
local typescript_ok, typescript = pcall(require, "typescript")
-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
  local ts_capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_nvim_lsp_ok then
    -- ts_capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    ts_capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
    ts_capabilities.textDocument.completion.completionItem.snippetSupport = true
    ts_capabilities.textDocument.completion.completionItem.preselectSupport = true
    ts_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    ts_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    ts_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    ts_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    ts_capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    ts_capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }
    ts_capabilities.textDocument.codeAction = {
      dynamicRegistration = false,
      codeActionLiteralSupport = {
        codeActionKind = {
          valueSet = {
            "",
            "quickfix",
            "refactor",
            "refactor.extract",
            "refactor.inline",
            "refactor.rewrite",
            "source",
            "source.organizeImports",
          },
        },
      },
    }
  end

  local ts_on_attach = function(client, bufnr)
    -- formatting is done with null-ls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    client.server_capabilities.document_formatting = false
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.keymap.set("n", "<Leader>es", ":EslintFix<CR>", { buffer = bufnr, silent = true })
    require("lsp").on_attach(client, bufnr)
  end

  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    -- LSP Config options
    server = {
      capabilities = ts_capabilities,
      on_attach = ts_on_attach,
    },
  })
end

-- rust setup
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(client, bufnr)
      -- formatting is done with null-ls
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.document_formatting = false
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      require("lsp").on_attach(client, bufnr)
    end,
  },
})
