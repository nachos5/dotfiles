return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local lsp = require("lsp")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- print("Attached to LSP:", client.name)
        lsp.on_attach(client, args.buf, client.name == "null-ls")
      end,
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }, -- Recognize 'vim' as a global.
          },
          workspace = {
            checkThirdParty = false,
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
              [vim.fn.expand("${3rd}/love2d/library")] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    vim.lsp.config("pyright", {
      root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
      },
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

    vim.lsp.config("ts_ls", {
      capabilities = {
        documentFormattingProvider = false,
      },
      init_options = {
        preferences = {
          providePrefixAndSuffixTextForRename = false,
        },
      },
    })

    -- Only used for automatically enabling mason lsp's (`vim.lsp.enable`).
    require("mason-lspconfig").setup()
  end,
}
