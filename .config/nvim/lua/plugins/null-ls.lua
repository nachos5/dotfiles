local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  -- debug = true,
  -- update_in_insert = true,
  on_attach = require("lsp").on_attach,
  sources = {
    -- python
    formatting.black.with({
      prefer_local = "env/bin",
      extra_args = { "--fast" },
    }),
    formatting.isort.with({
      prefer_local = "env/bin",
    }),
    diagnostics.pylint.with({
      prefer_local = "env/bin",
      timeout = 10000,
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),

    -- js/ts etc...
    formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      timeout = 10000,
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "graphql",
        "handlebars",
      },
    }),

    -- lua
    formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.expand("~/.config/stylua/.stylua.toml") },
    }),

    -- rust
    formatting.rustfmt,

    -- php
    -- formatting.phpcsfixer,
    diagnostics.php,
  },
})
