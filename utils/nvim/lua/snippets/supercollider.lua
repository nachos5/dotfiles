local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local my_sc_snippets = {
  -- Control structure
  s("if", fmt("if([], {[]}, {[]})", { i(1, "test"), i(2, ""), i(3, "") }, { delimiters = "[]" })),
  s(
    "switch",
    fmt(
      [[switch ([],
	[], { [] },
	[], { [] }
	); ]],
      {
        i(1, "variable"),
        i(2, "1"),
        i(3, '"isone".postln'),
        i(4, "2"),
        i(5, '"istwo".postln'),
      },
      {
        delimiters = "[]",
      }
    )
  ),

  -- SynthDef
  s("synthdef", {
    t({ "SynthDef(\\, {", "\t" }),
    t({ "var snd;", "\t" }),
    t({ "snd = SinOsc.ar;", "\t" }),
    t({ "snd = snd * Env.perc(0.01, 0.5).ar(Done.freeSelf);", "\t" }),
    t({ "snd = snd * \\amp.kr(-10).dbamp;", "\t" }),
    t({ "snd = snd ! 2;", "\t" }),
    t({ "Out.ar(\\out.kr(0), snd);", "" }),
    t("}).add;"),
  }),
}

-- ls.add_snippets("supercollider", my_sc_snippets)

return my_sc_snippets
