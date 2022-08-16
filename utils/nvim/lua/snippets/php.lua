local ls = require("luasnip")
local s = ls.snippet

local my_php_snippets = {
  s("dieencode", {
    t("die(json_encode("),
    i(1),
    t("));"),
    i(0),
  }),
}

return my_php_snippets
