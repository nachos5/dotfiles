local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local function has_file(file)
  return function(utils)
    return utils.root_has_file(file)
  end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = vim.env.NULL_LS_DEBUG ~= nil,
  -- update_in_insert = true,
  on_attach = require("lsp").on_attach,
  sources = {
    -- python
    formatting.black.with({
      prefer_local = "env/bin",
      timeout = 10000,
      extra_args = { "--fast" },
    }),
    formatting.isort.with({
      prefer_local = "env/bin",
    }),
    diagnostics.flake8.with({
      prefer_local = "env/bin",
      timeout = 10000,
      condition = has_file(".flake8"),
    }),
    diagnostics.pylint.with({
      prefer_local = "env/bin",
      timeout = 10000,
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      condition = has_file(".pylintrc"),
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
    -- https://github.com/prettier/plugin-php
    formatting.prettier.with({
      filetypes = {
        "php",
      },
    }),
    diagnostics.php,
  },
})
