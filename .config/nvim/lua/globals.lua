-- OS.
vim.g.IS_WINDOWS = vim.loop.os_uname().sysname == "Windows_NT"
vim.g.OS_HOME = vim.g.IS_WINDOWS and os.getenv("USERPROFILE") or os.getenv("HOME")

-- Config.
vim.g.MY_CONFIG = {
  -- Python.
  VIRTUAL_ENV = vim.env.VIRTUAL_ENV,
  VENV_PATH = vim.env.VENV_PATH,
  -- Null-ls.
  DISABLE_SLOW_SOURCES = vim.env.DISABLE_SLOW_SOURCES == "1",
  DISABLE_FORMATTING = vim.env.DISABLE_FORMATTING == "1",
  DISABLE_PRETTIER = vim.env.DISABLE_PRETTIER == "1",
  NULL_LS_DEBUG = vim.env.NULL_LS_DEBUG == "1",
  -- LSP.
  PYRIGHT_OPEN_FILES_ONLY = vim.env.PYRIGHT_OPEN_FILES_ONLY == "1",
  PYRIGHT_DISABLE_DIAGNOSTICS = vim.env.PYRIGHT_DISABLE_DIAGNOSTICS == "1",
  -- Git.
  GIT_DEFAULT_BRANCH = vim.env.GIT_DEFAULT_BRANCH and vim.env.GIT_DEFAULT_BRANCH or "master",
  -- Other.
  IS_COLEMAK = vim.env.IS_COLEMAK == "1",
  CLAUDE_API_KEY = vim.env.CLAUDE_API_KEY,
  DAP_REMOTE_ROOT = vim.env.DAP_REMOTE_ROOT,
  NOTES_PROJECT_NAME = vim.env.NOTES_PROJECT_NAME,
}
