local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local my_python_snippets = {
  --logging
  s("log", {
    t("print("),
    i(1),
    t(")"),
    i(0),
  }),

  -- logging with string label
  s("logl", {
    t("print("),
    t('"'),
    rep(1),
    t('"'),
    t(", "),
    i(1),
    t(")"),
    i(0),
  }),

  -- default import
  s("impd", {
    t("import "),
    i(1),
  }),

  -- named import
  s("impn", {
    t("from "),
    i(1),
    t(" import "),
    i(0),
  }),

  s("debugpy_remote", {
    t({
      "import debugpy",
      'debugpy.listen(("0.0.0.0", 5678))',
      "debugpy.wait_for_client()",
    }),
  }),

  s("debugpy_local", {
    t({
      "import debugpy",
      'debugpy.listen(("localhost", 5678))',
      "debugpy.wait_for_client()",
    }),
  }),
}

-- ls.add_snippets("python", my_python_snippets)

return my_python_snippets
