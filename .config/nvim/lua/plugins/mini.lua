return {
  "nvim-mini/mini.nvim",
  version = false,
  lazy = false,
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        { mode = { "n", "x" }, keys = "<Leader>" },
        { mode = { "n", "x" }, keys = "<LocalLeader>" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "i", keys = "<C-x>" },
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = { "n", "x" }, keys = "z" },
      },
      clues = {
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = "n", keys = "<Leader>x", desc = "+Trouble" },
      },
      window = {
        delay = 200,
        config = { anchor = "SW", row = "auto", col = "auto" },
      },
    })

    local animate = require("mini.animate")
    animate.setup({
      cursor = { enable = false },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 120, unit = "total" }),
      },
      resize = { enable = false },
      open = { enable = false },
      close = { enable = false },
    })

    local function scroll_window(key, select_mode)
      local count = math.max(1, math.floor(vim.api.nvim_win_get_height(0) * 0.1 + 0.5))
      local keys = count .. vim.keycode(key)
      if select_mode then
        keys = vim.keycode("<C-o>") .. keys
        vim.api.nvim_feedkeys(keys, "n", false)
        return
      end
      vim.cmd.normal({ args = { keys }, bang = true })
    end

    vim.keymap.set({ "n", "x" }, "<C-y>", function()
      scroll_window("<C-y>")
    end, { desc = "Scroll window up 10%" })
    vim.keymap.set("s", "<C-y>", function()
      scroll_window("<C-y>", true)
    end, { desc = "Scroll window up 10%" })
    vim.keymap.set({ "n", "x" }, "<C-e>", function()
      scroll_window("<C-e>")
    end, { desc = "Scroll window down 10%" })
    vim.keymap.set("s", "<C-e>", function()
      scroll_window("<C-e>", true)
    end, { desc = "Scroll window down 10%" })

    -- ga=
    require("mini.align").setup()

    require("mini.ai").setup()

    require("mini.bufremove").setup()

    require("mini.comment").setup({
      options = {
        ignore_blank_line = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    -- gS
    require("mini.splitjoin").setup()

    require("mini.surround").setup({
      mappings = {
        add = "ss", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    })

    require("mini.icons").setup({
      extension = {
        ["local"] = {
          glyph = "⚙️",
        },
        lock = {
          glyph = "",
        },
      },
    })
    MiniIcons.mock_nvim_web_devicons()

    require("mini.pairs").setup()
  end,
}
