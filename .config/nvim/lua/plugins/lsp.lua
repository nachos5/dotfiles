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

    local pyright_handlers = {
      -- Override the default rename handler to remove the `annotationId` from edits.
      --
      -- Pyright is being non-compliant here by returning `annotationId` in the edits, but not
      -- populating the `changeAnnotations` field in the `WorkspaceEdit`. This causes Neovim to
      -- throw an error when applying the workspace edit.
      --
      -- See:
      -- - https://github.com/neovim/neovim/issues/34731
      -- - https://github.com/microsoft/pyright/issues/10671
      [vim.lsp.protocol.Methods.textDocument_rename] = function(err, result, ctx)
        if err then
          vim.notify("Pyright rename failed: " .. err.message, vim.log.levels.ERROR)
          return
        end

        ---@cast result lsp.WorkspaceEdit
        for _, change in ipairs(result.documentChanges or {}) do
          for _, edit in ipairs(change.edits or {}) do
            if edit.annotationId then
              edit.annotationId = nil
            end
          end
        end

        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
        vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
      end,
    }

    if require("env").config.PYRIGHT_DISABLE_DIAGNOSTICS then
      pyright_handlers["textDocument/publishDiagnostics"] = function() end
    end

    vim.lsp.config("pyright", {
      root_markers = {
        -- Order matters (priority).
        "pyrightconfig.json",
        "pyproject.toml",
        "requirements.txt",
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
      handlers = pyright_handlers,
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
