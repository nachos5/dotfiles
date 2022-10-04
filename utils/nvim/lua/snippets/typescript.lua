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
    t({ "Props {", "\tclassName?: string;", "" }),
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
    -- export
    t({ "", "export { " }),
    rep(1),
    t(" };"),
  }),

  -- useEffect
  s("useeffect", {
    t({ "useEffect(() => {", "\t" }),
    i(0),
    t({ "", "}, []);" }),
  }),

  -- useState
  s("usestate", {
    t("const ["),
    i(1),
    t(", "),
    d(2, function(args)
      local s = args[1][1]
      -- print(require("utils").dump(args))
      if s ~= nil then
        s = args[1][1]:sub(1, 1):upper()
        if args[1][1]:len() > 1 then
          s = s .. args[1][1]:sub(2)
        end
        s = "set" .. s
      end

      return sn(nil, {
        t(s),
      })
    end, { 1 }),
    t("] = useState("),
    i(0),
    t(");"),
  }),

  s("useref", {
    t("const ref = useRef(null)"),
  }),
}

ls.add_snippets("typescriptreact", my_ts_snippets)

return my_ts_snippets
