local utils = require("utils")

-- :NullLsInfo

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local project_config_ok, project_config = pcall(dofile, vim.fn.getcwd() .. "/.project.lua")

local function has_file(file)
  return function(_utils)
    return _utils.root_has_file(file)
  end
end

local function check_for(paths)
  return function(_)
    for path, pattern in pairs(paths) do
      if utils.file_contains(path, pattern) then
        return true
      end
    end
    return false
  end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- relative path
local venv_path = vim.env.VENV_PATH and vim.env.VENV_PATH or "env"

local isort_pairs = {
  ["isort.cfg"] = ".*",
  ["pyproject.toml"] = "tool.isort",
}
local flake_pairs = { [".flake8"] = ".*" }
local pylint_pairs = {
  [".pylintrc"] = ".*",
  [".pylint.toml"] = ".*",
  ["pyproject.toml"] = "tool.pylint",
}
local mypy_pairs = {
  ["mypy.ini"] = ".*",
  ["pyproject.toml"] = "tool.mypy",
}
local ruff_pairs = {
  ["ruff.toml"] = ".*",
  ["pyproject.toml"] = "ruff.mypy",
}

local black_config = {
  prefer_local = venv_path .. "/bin",
  timeout = 10000,
  extra_args = { "--fast" },
}
local mypy_config = {
  prefer_local = venv_path .. "/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  condition = check_for(mypy_pairs),
}
local pylint_config = {
  prefer_local = venv_path .. "/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  condition = check_for(pylint_pairs),
}
local flake_config = {
  prefer_local = venv_path .. "/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  condition = check_for(flake_pairs),
}
local ruff_config = {
  prefer_local = venv_path .. "/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  condition = check_for(ruff_pairs),
}
local ruff_formatting_config = {
  prefer_local = venv_path .. "/bin",
  condition = check_for(ruff_pairs),
}

-- check for project config
if project_config_ok then
  if type(rawget(project_config, "null_ls_black_config")) == "table" then
    black_config = project_config.null_ls_black_config
  end
  if type(rawget(project_config, "null_ls_mypy_config")) == "table" then
    mypy_config = project_config.null_ls_mypy_config
  end
  if type(rawget(project_config, "null_ls_pylint_config")) == "table" then
    pylint_config = project_config.null_ls_pylint_config
  end
  if type(rawget(project_config, "null_ls_flake_config")) == "table" then
    flake_config = project_config.null_ls_flake_config
  end
  if type(rawget(project_config, "null_ls_ruff_config")) == "table" then
    ruff_config = project_config.null_ls_ruff_config
  end
  if type(rawget(project_config, "null_ls_ruff_formatting_config")) == "table" then
    ruff_formatting_config = project_config.null_ls_ruff_formatting_config
  end
end

null_ls.setup({
  debug = vim.env.NULL_LS_DEBUG ~= nil,
  -- update_in_insert = true,
  on_attach = require("lsp").on_attach,
  sources = {
    -- python
    formatting.black.with(black_config),
    formatting.isort.with({
      prefer_local = venv_path .. "/bin",
      condition = check_for(isort_pairs),
    }),
    formatting.ruff.with(ruff_formatting_config),
    diagnostics.flake8.with(flake_config),
    diagnostics.pylint.with(pylint_config),
    diagnostics.mypy.with(mypy_config),
    diagnostics.ruff.with(ruff_config),

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

    -- shell
    formatting.shfmt,

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
