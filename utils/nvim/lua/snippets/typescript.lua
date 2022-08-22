local ls = require("luasnip")
local s = ls.snippet

local my_ts_snippets = {
  -- logging
  s("log", {
    t("console.info("),
    i(1),
    t(")"),
    i(0),
  }),

  -- default import
  s("impd", {
    t("import "),
    i(2),
    t(' from "'),
    i(1),
    t('";'),
    i(0),
  }),

  -- named import
  s("impn", {
    t("import { "),
    i(2),
    t(' } from "'),
    i(1),
    t('";'),
    i(0),
  }),
}

ls.add_snippets("typescriptreact", my_ts_snippets)

return my_ts_snippets
