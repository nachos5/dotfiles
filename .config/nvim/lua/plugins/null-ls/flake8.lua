local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")
local utils = require("null-ls.utils")

local DIAGNOSTICS = methods.internal.DIAGNOSTICS

local custom_end_col = {
  end_col = function(entries, line)
    if not line then
      return
    end

    local start_col = entries["col"]
    local message = entries["message"]
    local code = entries["code"]

    -- highlights only first character on error line, if not specified otherwise
    local default_position = start_col + 1

    local pattern = nil
    local trimmed_line = line:sub(start_col, -1)

    if code == "F841" or code == "F823" then
      pattern = [[local variable %'(.*)%']]
    elseif code == "F821" or code == "F822" then
      pattern = [[undefined name %'(.*)%']]
    elseif code == "F831" then
      pattern = [[duplicate argument %'(.*)%']]
    elseif code == "F401" then
      pattern = [[%'(.*)%' imported]]
    end

    if not pattern then
      return default_position
    end

    local results = message:match(pattern)
    local _, end_col = trimmed_line:find(results, 1, true)

    if not end_col then
      return default_position
    end

    end_col = end_col + start_col
    if end_col > tonumber(start_col) then
      return end_col
    end

    return default_position
  end,
}

return helpers.make_builtin({
  name = "flake8",
  meta = {
    url = "https://github.com/PyCQA/flake8",
    description = "flake8 is a python tool that glues together pycodestyle, pyflakes, mccabe, and third-party plugins to check the style and quality of Python code.",
  },
  method = DIAGNOSTICS,
  filetypes = { "python" },
  generator_opts = {
    command = "flake8",
    to_stdin = true,
    from_stderr = true,
    args = { "--format", "default", "--stdin-display-name", "$FILENAME", "-" },
    format = "line",
    check_exit_code = function(code)
      return code == 0 or code == 255
    end,
    on_output = helpers.diagnostics.from_pattern(
      [[:(%d+):(%d+): ((%u)%w+) (.*)]],
      { "row", "col", "code", "severity", "message" },
      {
        adapters = {
          custom_end_col,
        },
        severities = {
          E = helpers.diagnostics.severities["error"],
          W = helpers.diagnostics.severities["warning"],
          F = helpers.diagnostics.severities["information"],
          D = helpers.diagnostics.severities["information"],
          R = helpers.diagnostics.severities["warning"],
          S = helpers.diagnostics.severities["warning"],
          I = helpers.diagnostics.severities["warning"],
          C = helpers.diagnostics.severities["warning"],
          B = helpers.diagnostics.severities["warning"], -- flake8-bugbear
          N = helpers.diagnostics.severities["information"], -- pep8-naming
        },
      }
    ),
    cwd = helpers.cache.by_bufnr(function(params)
      return utils.root_pattern(
        -- https://flake8.pycqa.org/en/latest/user/configuration.html
        ".flake8",
        "setup.cfg",
        "tox.ini"
      )(params.bufname)
    end),
  },
  factory = helpers.generator_factory,
})
