local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rnd = function()
  return f(function()
    return "" .. math.random() .. ""
  end, {})
end
local function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end
local my_sc_snippets = {
  -- kometpat
  s(
    "pcomplex",
    fmt(
      [[(
Pbind(
	\type, \k,
	\base, [],
	\env, [],
	\filter, [],
	\category, [],
	\freq, [],
	\freqOffset, [],
	\dur, [],
	\lagTime, 0.0,
	\legato, [],
	\amp, [],
	\filtertype, [],
	\fenvAmount, [],
	\cutoff, [],
	\pan, [],
	\panFreq, [],
	\autopan, [],
	\panShape, [],
	\atk, [],
	\sus, [],
	\rel, [],
	\curve, []
	\pitchEnvAmount, []
).play;
)]],
      {
        i(1, "\\complex"),
        i(2, "\\adsr"),
        i(3, "\\vadim"),
        i(4, "\\synthetic"),
        i(5, "Pwhite(100,500)"),
        i(6, "0"),
        i(7, "1.0"),
        i(8, "1.0"),
        i(9, "0.125"),
        i(10, "2"),
        i(11, "0"),
        i(12, "500"),
        i(13, "Pwhite(-0.5,0.5)"),
        i(14, "1.0"),
        i(15, "0.001"),
        i(16, "KPanShape.sine"),
        i(17, "0.25"),
        i(18, "0.5"),
        i(19, "0.25"),
        i(20, "(-5)"),
        i(21, "0"),
      },
      { delimiters = "[]" }
    )
  ),
  s(
    "pk",
    fmt(
      [[(
Pbind(
    \type, \k,
	\base, [],
	\env, [],
	\filter, [],
	\category, [],
    \freq, [],
    \freqOffset, 0.0,
    \dur, [],
    \lagTime, 0.0,
    \legato, 1,
    \amp, 0.125,
	\filtertype, 2,
    \fenvAmount, 0.0,
    \cutoff, Pseg(Pwhite(1000, 4500,inf),64,\lin,inf),
    \pan, Pwhite(-0.5,0.5),
    \panFreq, 1.0,
    \autopan, 0.0,
    \panShape, KPanShape.sine,
    \atk, 0.5,
    \sus, 1,
    \rel, 0.5,
    \curve, Pwhite(-5,5),
).play;
)]],
      { i(1, "\\complex"), i(2, "\\adsr"), i(3, "\\vadim"), i(4, "\\synthetic"), i(5, "Pwhite(100,500)"), i(6, "1.0") },
      { delimiters = "[]" }
    )
  ),
  -- komet
  s(
    "ksynth",
    fmt(
      [[(
var desc = "[]",
	func = [],
	type = [],
	category = [],
	basename = [],
	numChans = [],
	specs = ();
KometSynthFuncDef(
	basename,
	func,
	type,
	category,
	numChans,
	desc,
	specs,
).add();
)]],
      { i(1, ""), i(2, ""), i(3, "\\synth"), i(4, "\\physical"), i(5, "\\name"), i(6, "1") },
      { delimiters = "[]" }
    )
  ),
  s(
    "kfx",
    fmt(
      [[(
var desc = "[]",
	func = [],
	type = [],
	category = [],
	basename = [],
	numChans = nil, // TODO: Not used
	specs = ();
KometSynthFuncDef(
	basename,
	func,
	type,
	category,
	numChans,
	desc,
	specs,
).add();
)]],
      { i(1, ""), i(2, ""), i(3, "\\fx"), i(4, "\\channelized"), i(5, "\\name") },
      { delimiters = "[]" }
    )
  ),
  -- Control structure
  s("if", fmt("if([], {[]}, {[]})", { i(1, "test"), i(2, ""), i(3, "") }, { delimiters = "[]" })),
  -- s("pseg", fmt("Pseg([{}], {}, {}, {})", i(1, "1.0,0.0"), i(2, "16"), i(3, "\\lin"), i(4, "inf"))),
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
  -- Pseg
  -- s("pseg", fmt("Pseg([{}], {}, {}, {})", i(1, "1.0,0.0"), i(2, "16"), i(3, "\\lin"), i(4, "inf"))),
  -- Buffer stuff
  s("b", {
    i(1, "b"),
    t(" "),
    t("="),
    t(" "),
    t("Buffer.read("),
    t('s, "'),
    i(2, "~/testsound/pots.wav"),
    t('".asAbsolutePath)'),
  }),
  -- Value pattern shorthands
  s("pwh", { t("Pwhite("), c(1, { t("0.0"), rnd() }), t(", "), c(1, { t("1.0"), rnd() }), t(")") }),
  s("pbr", { t("Pbrown("), i(1, "0.0"), t(", "), i(2, "1.0"), t(", "), i(3, "0.125"), t(")") }),
  s("ps", { t("Pseq(["), i(1, "1.0"), t("], "), i(2, "inf"), t(")") }),
  s("pr", { t("Prand(["), i(1, "1.0"), t("], "), i(2, "inf"), t(")") }),
  s("pxr", { t("Prand(["), i(1, "1.0"), t("], "), i(2, "inf"), t(")") }),
  s("pw", { t("Pwrand(["), i(1, "100.5, 2.5"), t("], ["), i(2, "0.5, 0.5"), t("], "), i(3, "inf"), t(")") }),
  s(
    "pseg",
    { t("Pseg("), t("["), i(1, "1.0,0.0"), t("],"), i(2, "16"), t(","), i(3, "\\lin"), t(","), i(4, "inf"), t(")") }
  ),
  s("pstep", { t("Pstep("), t("["), i(1, "1.0,0.0"), t("],"), i(2, "16"), t(","), i(3, "inf"), t(")") }),
  -- Misc Pattern
  s("pf", { t("Pfunc({|ev| "), i(1, ""), t(" })") }),
  s("pp", { t("Ppar(["), i(1, "p,o"), t("], "), i(2, "inf"), t(")") }),
  s("ptp", { t("Ptpar(["), i(1, "0.0, p, 2.0, o"), t("], "), i(2, "inf"), t(")") }),
  -- Record score as NRT
  s(
    "recnrt",
    fmt(
      [[
	{}.recordNRT (
	outputFilePath: "{}.wav".format(Date.getDate.stamp).asAbsolutePath,
	sampleRate: {},
	headerFormat: "WAV",
	sampleFormat: "int32",
	options: {},
	duration: {},
	action: {}
	) ]],
      {
        i(1, "score"),
        d(2, function(args, snip)
          local text = vim.fn.expand("%:t:r")
          return i(nil, text .. "_ATK_HOA_%")
        end, {}),
        i(3, "44100"),
        i(4, "s.options"),
        i(5, "256"),
        i(6, '{ "done".postln }'),
      }
    )
  ),
  -- assert
  s("assert", { t("this.assert("), i(1, "6 == 6"), t(","), i(2, '"testing something something"'), t(")") }),
  -- assertequals
  s("assertequals", {
    t("this.assertEquals("),
    i(1, "6 + 6"),
    t(","),
    i(2, "12"),
    t(","),
    i(3, '"testing something something"'),
    t(")"),
  }),
  -- Ndef
  s("ndef", {
    t("Ndef("),
    t("\\"),
    i(1, "name"),
    t(",{|"),
    i(2, "freq=100, amp=0.5"),
    t({ "|", "" }),
    t("\t"),
    i(2, "SinOsc.ar(freq) * amp;"),
    t({ "", "" }),
    t({ "", "})" }),
    i(3, ".play"),
  }),
  -- SynthDef
  s("synthdef", {
    t("SynthDef("),
    t("\\"),
    i(1, "name"),
    t(", { |"),
    i(2, "out=0, amp=(-10)"),
    t({ "|", "" }),
    t("\t"),
    t({ "var sig;", "\t" }),
    i(3, "sig = SinOsc.ar;"),
    t({ "", "" }),
    t("\t"),
    i(4, "Out.ar(out, sig);"),
    t({ "", "})" }),
    i(5, ".add"),
  }),
  -- test class
  s({
    trig = "test",
    dscr = "SuperCollider unit test class snippet",
  }, {
    -- Test Class name
    t("Test_"),
    d(1, function(args, snip)
      local text = firstToUpper(vim.fn.expand("%:t:r"))
      return i(nil, text)
    end, {}),
    i(2, " : UnitTest"),
    -- Start of class
    t({ "{", "" }),
    -- Setup
    i(3, "setUp"),
    t("{"),
    t({ "", "" }),
    i(4, "// Setup here"),
    t({ "", "}", "", "" }),
    -- Tear down
    i(5, "tearDown"),
    t({ "{", "" }),
    i(6, "// Remove resources here"),
    t({ "", "", "\t" }),
    t({ "", "}", "", "" }),
    -- Test method
    t("test_"),
    i(7, "yourMethod"),
    t({ "{", "", "" }),
    i(8, 'this.assert( 6 == 6, "6 should equal 6"); '),
    t({ "", "}", "" }),
    -- End of class
    t("}"),
  }),
  -- Class
  s({
    trig = "class",
    dscr = "SuperCollider class snippet",
  }, {
    -- Class name
    i(1, firstToUpper(vim.fn.expand("%:t:r"))),
    -- Start of class
    t({ "{", "" }),
    -- Class method *new
    i(2, "*new"),
    t("{"),
    -- Arguments with optional braces (if any arguments)
    -- f(function(args, snip) if args[1][1] ~= "" then return "|" else return "" end end, {3}),
    t("|"),
    i(3, "arga, argb"),
    t("|"),
    -- f(function(args, snip) if args[1][1] ~= "" then return "|" else return "" end end, {3}),
    t({ "", "" }),
    f(function(args, snip)
      local classMethodName = args[1][1]
      local scclassArgs = args[2][1]
      local initFuncName = args[3][1]
      return string.format("\t^super.%s.%s(%s)", string.gsub(classMethodName, "*", ""), initFuncName, scclassArgs)
    end, { 2, 3, 4 }),
    t({ "", "}", "", "" }),
    -- Init function arguments
    i(4, "init"),
    t("{"),
    f(function(args, snip)
      local scclassArgs = args[1][1]
      if scclassArgs == "" then
        return ""
      else
        return string.format("|%s|", scclassArgs)
      end
    end, { 3 }),
    t({ "", "", "\t" }),
    i(5, "// init stuff"),
    t({ "", "}", "", "" }),
    -- End of class
    t("}"),
  }),
  -- s("calc", {
  -- 	i(1, "2+2"),
  -- 	f(
  -- 		function(args, snip, user_arg_1)
  -- 			local result
  -- 			print(args[1][1])
  -- 			require'scnvim'.eval(
  -- 				args[1][1],
  -- 				function(res)
  -- 					result = res
  -- 				end
  -- 			)
  -- 			return result
  -- 		end,
  -- 		{1}),
  -- 	i(0)
  -- }),
  --
  -- s("testcl",{
  -- 	fmt([[Test<> : UnitTest {{
  -- 	setUp {{
  -- 		<>
  -- 	}}
  -- 	tearDown {{
  -- 		<>
  -- 	}}
  -- 	test_<> {{
  -- 		<>
  -- 	}}
  -- 		}}]], {
  -- 			i(1, "ClassName"),
  -- 			i(2, "Setup code"),
  -- 			i(3, "tear down code"),
  -- 			i(4, "methodName"),
  -- 			i(5, "Assertion here"),
  -- 		},
  -- 		{
  -- 			delimiters = "<>"
  -- 		}
  -- 	)
  -- }),
  -- Plambda
  s("plambda", {
    t({ "Plambda(", "" }),
    t({ "Ppar([", "" }),
    t({ "Pbind(", "" }),
    i(1, "\\dur"),
    t(","),
    i(2, "0.125"),
    t({ ",", "" }),
    i(3, "\\octave"),
    t(","),
    i(4, "4"),
    t({ ",", "" }),
    i(5, "\\degree"),
    t(","),
    i(6, "Plet(\\melody, pattern: Pwhite(2, 07))"),
    t({ "" }),
    t({ "", "),", "" }),
    t({ "Pbind(", "" }),
    i(7, "\\dur"),
    t(","),
    i(8, "0.125"),
    t({ ",", "" }),
    i(9, "\\octave"),
    t(","),
    i(9, "3"),
    t({ ",", "" }),
    i(10, "\\degree"),
    t(","),
    i(11, "Pget(\\melody, default: 1, repeats: inf)"),
    t({ "", "" }),
    t({ ")", "" }),
    t({ "]", ",", "" }),
    t({ "inf)", "" }),
    t({ ")" }),
  }),
  -- Pspawn
  s("pspawn", {
    t({ "Pspawn(", "Pbind(", "" }),
    t("\\method,"),
    i(1, "Prand([\\par, \\seq, \\wait, \\suspendAll], inf)"),
    t({ ",", "" }),
    t({ "\\delta, " }),
    i(2, "Pwhite(1, 5, inf) * 0.125"),
    t({ ",", "" }),
    t({ "\\pattern, Pfunc {|ev|", "" }),
    t({ "var delta = ev[\\delta] ? 1;", "" }),
    t({ "Pbind(", "" }),
    i(3, "\\degree"),
    t(","),
    i(4, "Pseries(rrand(0, 10), #[-1, 1].choose, rrand(4, 10))"),
    t({ ", ", " " }),
    i(5, "\\dur"),
    t(","),
    i(6, "delta/10"),
    t({ "", ")" }),
    t({ "},", ")", ")" }),
  }),
  -- Pfx
  s(
    "pfx",
    fmt(
      [[
		Pfx({}, {}, {}, {});
		]],
      { i(1, "p"), i(2, "\\delay"), i(3, "\\delaytime"), i(4, "0.25") }
    )
  ),
  -- s("chooose", c(1, {
  -- 	t("Ugh boring, a text node"),
  -- 	i(nil, "At least I can edit something now..."),
  -- 	f(function(_) return "Still only counts as text!!" end, {})
  -- }))
}

return my_sc_snippets
