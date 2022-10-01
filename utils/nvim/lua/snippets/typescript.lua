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

  -- react component
  s("rc", {
    -- imports
    t({ 'import classNames from "classnames";', "", "" }),
    -- interface
    t("interface "),
    rep(1),
    t({ "Props {", "\tclassName: string;", "" }),
    t("\t"),
    i(0),
    t({ "", "}", "", "" }),
    -- component
    t("const "),
    i(1),
    t(" = ({ className }: "),
    rep(1),
    t({ "Props) => {", "\t", "\treturn (", "\t\t<div className={classNames(className)}>", "" }),
    t("\t\t\t"),
    rep(1),
    t({ "", "\t\t</div>", "\t)", "}", "" }),
    -- expor"\t),"t
    t({ "", "export { " }),
    rep(1),
    t(" };"),
  }),
}

ls.add_snippets("typescriptreact", my_ts_snippets)

return my_ts_snippets
