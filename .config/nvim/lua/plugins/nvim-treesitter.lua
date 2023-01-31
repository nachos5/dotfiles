-- Load custom tree-sitter grammar for org filetype
require("orgmode").setup_ts_grammar()

-- Tree-sitter configuration
require("nvim-treesitter.configs").setup({
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = { "help" },
    additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = { "org" }, -- Or run :TSUpdate org
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
})

-- <Leader\>oa - agenda
-- <Leader>oc - capture
require("orgmode").setup({
  org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
  org_default_notes_file = "~/Dropbox/org/refile.org",
  mappings = {
    agenda = {
      org_agenda_goto = { ".", "T" },
    },
  },
})
