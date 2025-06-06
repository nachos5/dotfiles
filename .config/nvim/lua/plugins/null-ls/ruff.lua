local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")
local DIAGNOSTICS = methods.internal.DIAGNOSTICS

local custom_end_col = {
  end_col = function(entries, line)
    if not line then
      return
    end

    local start_col = entries["col"]
    local message = entries["message"]
    local code = entries["code"]
    local default_position = start_col + 1

    local pattern = nil
    local trimmed_line = line:sub(start_col, -1)

    if code == "F841" or code == "F823" then
      pattern = [[Local variable %`(.*)%`]]
    elseif code == "F821" or code == "F822" then
      pattern = [[Undefined name %`(.*)%`]]
    elseif code == "F401" then
      pattern = [[%`(.*)%` imported but unused]]
    elseif code == "F841" then
      pattern = [[Local variable %`(.*)%` is assigned to but never used]]
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
  name = "ruff",
  meta = {
    url = "https://github.com/astral-sh/ruff/",
    description = "An extremely fast Python linter, written in Rust.",
  },
  method = DIAGNOSTICS,
  filetypes = { "python" },
  generator_opts = {
    command = "ruff",
    args = {
      "-n",
      "-e",
      "--stdin-filename",
      "$FILENAME",
      "-",
    },
    format = "line",
    check_exit_code = function(code)
      return code == 0
    end,
    to_stdin = true,
    ignore_stderr = true,
    on_output = helpers.diagnostics.from_pattern(
      [[(%d+):(%d+): ((%u)%w+) (.*)]],
      { "row", "col", "code", "severity", "message" },
      {
        adapters = {
          custom_end_col,
        },
        severities = {
          E = helpers.diagnostics.severities["error"], -- pycodestyle errors
          W = helpers.diagnostics.severities["warning"], -- pycodestyle warnings
          F = helpers.diagnostics.severities["information"], -- pyflakes
          A = helpers.diagnostics.severities["information"], -- flake8-builtins
          B = helpers.diagnostics.severities["warning"], -- flake8-bugbear
          C = helpers.diagnostics.severities["warning"], -- flake8-comprehensions
          T = helpers.diagnostics.severities["information"], -- flake8-print
          U = helpers.diagnostics.severities["information"], -- pyupgrade
          D = helpers.diagnostics.severities["information"], -- pydocstyle
          M = helpers.diagnostics.severities["information"], -- Meta
        },
      }
    ),
  },
  factory = helpers.generator_factory,
})
