local M = {}

M.config = {
  -- Python.
  VIRTUAL_ENV = vim.env.VIRTUAL_ENV,
  VENV_PATH = vim.env.VENV_PATH,
  -- Null-ls.
  DISABLE_NULL_LS = vim.env.DISABLE_NULL_LS == "1",
  DISABLE_SLOW_SOURCES = vim.env.DISABLE_SLOW_SOURCES == "1",
  DISABLE_FORMATTING = vim.env.DISABLE_FORMATTING == "1",
  DISABLE_PRETTIER = vim.env.DISABLE_PRETTIER == "1",
  NULL_LS_DEBUG = vim.env.NULL_LS_DEBUG == "1",
  -- LSP.
  DISABLE_FORMAT_ON_SAVE = vim.env.DISABLE_FORMAT_ON_SAVE == "1",
  PYRIGHT_OPEN_FILES_ONLY = vim.env.PYRIGHT_OPEN_FILES_ONLY == "1",
  PYRIGHT_DISABLE_DIAGNOSTICS = vim.env.PYRIGHT_DISABLE_DIAGNOSTICS == "1",
  -- Git.
  GIT_DEFAULT_BRANCH = vim.env.GIT_DEFAULT_BRANCH and vim.env.GIT_DEFAULT_BRANCH or "master",
  -- gf.
  GF_PREFIXES_TO_CHECK = vim.env.GF_PREFIXES_TO_CHECK and vim.split(vim.env.GF_PREFIXES_TO_CHECK, ",") or {},
  -- LLM.
  LLM_PROVIDER = vim.env.LLM_PROVIDER == nil and "claude" or vim.env.LLM_PROVIDER,
  -- Claude.
  CLAUDE_API_KEY = vim.env.CLAUDE_API_KEY,
  -- Other.
  IS_COLEMAK = vim.env.IS_COLEMAK == "1",
  DAP_REMOTE_ROOT = vim.env.DAP_REMOTE_ROOT,
  NOTES_PROJECT_NAME = vim.env.NOTES_PROJECT_NAME,
}

return M
