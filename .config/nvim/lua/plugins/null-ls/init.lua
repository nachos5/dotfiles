require("project")
local utils = require("utils")

-- :NullLsInfo

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

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

local black_pairs = {
  ["pyproject.toml"] = "tool.black",
}
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
  [".ruff.toml"] = ".*",
  ["ruff.toml"] = ".*",
  ["pyproject.toml"] = "tool.ruff",
}
local ruff_formatting_pairs = {
  [".ruff.toml"] = "format",
  ["ruff.toml"] = "format",
  ["pyproject.toml"] = "tool.ruff.format",
}
local biome_pairs = {
  ["biome.json"] = ".*",
}

local black_config = {
  prefer_local = venv_path .. "/bin",
  timeout = 10000,
  extra_args = { "--fast" },
  condition = check_for(black_pairs),
}
local mypy_config = {
  prefer_local = venv_path .. "/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  condition = check_for(mypy_pairs),
  timeout = 15000,
}
local pylint_config = {
  prefer_local = venv_path .. "/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  condition = check_for(pylint_pairs),
  timeout = 15000,
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
  condition = check_for(ruff_formatting_pairs),
}
local biome_config = {
  prefer_local = "node_modules/.bin",
  condition = check_for(biome_pairs),
}

-- check for project config
if PROJECT_CONFIG_OK then
  -- python
  if type(rawget(PROJECT_CONFIG, "null_ls_black_config")) == "table" then
    black_config = PROJECT_CONFIG.null_ls_black_config
  end
  if type(rawget(PROJECT_CONFIG, "null_ls_mypy_config")) == "table" then
    mypy_config = PROJECT_CONFIG.null_ls_mypy_config
  end
  if type(rawget(PROJECT_CONFIG, "null_ls_pylint_config")) == "table" then
    pylint_config = PROJECT_CONFIG.null_ls_pylint_config
  end
  if type(rawget(PROJECT_CONFIG, "null_ls_flake_config")) == "table" then
    flake_config = PROJECT_CONFIG.null_ls_flake_config
  end
  if type(rawget(PROJECT_CONFIG, "null_ls_ruff_config")) == "table" then
    ruff_config = PROJECT_CONFIG.null_ls_ruff_config
  end
  if type(rawget(PROJECT_CONFIG, "null_ls_ruff_formatting_config")) == "table" then
    ruff_formatting_config = PROJECT_CONFIG.null_ls_ruff_formatting_config
  end
  -- js
  if type(rawget(PROJECT_CONFIG, "null_ls_biome_config")) == "table" then
    biome_config = PROJECT_CONFIG.null_ls_biome_config
  end
end

-- Initilize with diagnostics sources.
local sources = {
  -- python
  require("plugins/null-ls/flake8").with(flake_config),
  require("plugins/null-ls/ruff").with(ruff_config),

  -- C
  require("plugins/null-ls/clang_check"),

  -- php
  -- diagnostics.php,
}

-- Add slow diagnostic sources if not disabled.
if vim.env.DISABLE_SLOW_SOURCES == nil then
  local slow_sources = {
    -- python
    diagnostics.pylint.with(pylint_config),
    diagnostics.mypy.with(mypy_config),
  }

  for _, value in ipairs(slow_sources) do
    table.insert(sources, value)
  end
end

-- Add formatting sources if not disabled.
if vim.env.DISABLE_FORMATTING == nil then
  local formatting_sources = {
    -- python
    formatting.black.with(black_config),
    formatting.isort.with({
      prefer_local = venv_path .. "/bin",
      condition = check_for(isort_pairs),
    }),
    require("plugins/null-ls/ruff_format").with(ruff_formatting_config),

    -- lua
    formatting.stylua.with({
      extra_args = { "--config-path", vim.fn.expand("~/.config/stylua/.stylua.toml") },
    }),

    -- C
    formatting.clang_format,

    -- rust
    require("plugins/null-ls/rustfmt"),

    -- shell
    formatting.shfmt,

    -- js
    formatting.biome.with(biome_config),

    -- php
    -- https://github.com/prettier/plugin-php
    formatting.prettier.with({
      filetypes = {
        "php",
      },
    }),
  }

  for _, value in ipairs(formatting_sources) do
    table.insert(sources, value)
  end

  -- prettier
  if vim.env.DISABLE_PRETTIER == nil then
    table.insert(
      sources,
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
      })
    )
  end
end

-- Wrapper method to enable formatting.
local function _on_attach(client, bufnr)
  require("lsp").on_attach(client, bufnr, true)
end

null_ls.setup({
  debug = vim.env.NULL_LS_DEBUG ~= nil,
  -- update_in_insert = true,
  on_attach = _on_attach,
  sources = sources,
})
