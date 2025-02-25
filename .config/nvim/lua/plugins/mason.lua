return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- "ray-x/lsp_signature.nvim",
  },
  config = function()
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")
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
        "pyright",
        "rust_analyzer",
        "lua_ls",
        -- "tailwindcss",
        "ts_ls",
        -- "yamlls",
      },
      automatic_installation = true,
    })

    require("neodev").setup({})

    local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status_ok then
      vim.notify("Couldn't load LSP-Config" .. lspconfig, vim.log.levels.ERROR)
      return
    end

    local ts_on_attach = function(client, bufnr)
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.keymap.set("n", "<Leader>es", ":EslintFix<CR>", { buffer = bufnr, silent = true })
      require("lsp").on_attach(client, bufnr)
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        if server_name == "ts_ls" or server_name == "rust_analyzer" then
          return
        end
        require("lspconfig")[server_name].setup({
          on_attach = function(client, bufnr)
            require("lsp").on_attach(client, bufnr)
          end,
        })
      end,

      ["pyright"] = function()
        lspconfig.pyright.setup({
          on_attach = require("lsp").on_attach,
          root_dir = require("lspconfig.util").root_pattern(unpack({
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
          })),
          settings = {
            pyright = {
              autoImportCompletion = true,
            },
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = require("env").config.PYRIGHT_OPEN_FILES_ONLY and "openFilesOnly" or "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
              },
            },
          },
          handlers = require("env").config.PYRIGHT_DISABLE_DIAGNOSTICS and {
            ["textDocument/publishDiagnostics"] = function() end,
          } or nil,
        })
      end,

      ["ts_ls"] = function()
        lspconfig.ts_ls.setup({
          on_attach = ts_on_attach,
          capabilities = {
            documentFormattingProvider = false,
          },
          init_options = {
            preferences = {
              providePrefixAndSuffixTextForRename = false,
            },
          },
        })
      end,
    })

    -- rust setup
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(client, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          require("lsp").on_attach(client, bufnr)
        end,
      },
    })
  end,
}
