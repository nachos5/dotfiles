return {
  "L3MON4D3/LuaSnip",
  version = "2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")

    -- Every unspecified option will be set to the default.
    ls.config.set_config({
      history = true,
      -- Update more often, :h events for more info.
      updateevents = "TextChanged,TextChangedI",
      ext_base_prio = 300,
      -- minimal increase in priority.
      ext_prio_increase = 1,
      enable_autosnippets = true,
    })
    ls.filetype_set("vimwiki", { "markdown" })
    -- ls.filetype_set("scdoc", { "supercollider" })
    require("luasnip/loaders/from_vscode").load()
    -- Make luasnip edit command
    vim.cmd([[
      command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()
      ]])

    -- Load all snippets
    require("luasnip.loaders.from_lua").load({ paths = "~/utils/nvim/lua/snippets" })

    vim.keymap.set({ "i", "s" }, "<C-down>", function()
      ls.jump(1)
    end, { silent = false })
    vim.keymap.set({ "i", "s" }, "<C-up>", function()
      ls.jump(-1)
    end, { silent = false })
  end,
}
