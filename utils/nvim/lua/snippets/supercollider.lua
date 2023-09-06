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

  -- (
  -- SynthDef(\, {
  --   var sig;
  --   sig = SinOsc.ar(\freq.kr(440));
  --   sig = sig * Env.perc(0.01, 0.5).ar(Done.freeSelf);
  --   sig = sig * \amp.kr(-10).dbamp;
  --   sig = sig ! 2;
  --   Out.ar(\out.kr(0), sig);
  -- }).add;
  -- )

  -- SynthDef
  s("synthdef", {
    t({ "SynthDef(\\, {", "\t" }),
    t({ "var sig;", "\t" }),
    t({ "sig = SinOsc.ar;", "\t" }),
    t({ "sig = sig * Env.perc(0.01, 0.5).ar(Done.freeSelf);", "\t" }),
    t({ "sig = sig * \\amp.kr(-10).dbamp;", "\t" }),
    t({ "sig = sig ! 2;", "\t" }),
    t({ "Out.ar(\\out.kr(0), sig);", "" }),
    t("}).add;"),
  }),
  -- s("synthdef", {
  --   t("SynthDef("),
  --   t("\\"),
  --   i(1, "name"),
  --   t(", { |"),
  --   i(2, "out=0, amp=(-10)"),
  --   t({ "|", "" }),
  --   t("\t"),
  --   t({ "var sig;", "\t" }),
  --   i(3, "sig = SinOsc.ar;"),
  --   t({ "", "" }),
  --   t("\t"),
  --   i(4, "Out.ar(out, sig);"),
  --   t({ "", "})" }),
  --  i(5, ".add"),
  -- }),
}

-- ls.add_snippets("supercollider", my_sc_snippets)

return my_sc_snippets
