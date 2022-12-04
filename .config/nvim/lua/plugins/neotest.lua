local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
  mappings = {
    attach = "a",
    clear_marked = "M",
    clear_target = "T",
    expand = { "<CR>", "<2-LeftMouse>" },
    expand_all = "e",
    jumpto = "i",
    mark = "m",
    output = "o",
    run = "r",
    run_marked = "R",
    short = "O",
    stop = "u",
    target = "t",
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "✖",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "✔",
    running = "~",
    skipped = "ﰸ",
    unknown = "?",
  },
})

nnoremap("<leader>ts", ":lua require('neotest').summary.open({ enter = true })<CR>", { silent = true })
