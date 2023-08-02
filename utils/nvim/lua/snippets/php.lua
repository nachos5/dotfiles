local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local my_php_snippets = {
  s("dieencode", {
    t("die(json_encode("),
    i(1),
    t("));"),
    i(0),
  }),
  s("errlog", {
    t({ "error_log('===================');", "" }),
    t("error_log(json_encode("),
    i(1),
    t({ "));", "" }),
    t({ "error_log('===================');", "" }),
    i(0),
  }),
}

return my_php_snippets
