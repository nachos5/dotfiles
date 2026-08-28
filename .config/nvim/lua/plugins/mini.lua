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

    require("mini.trailspace").setup()

    local function trim_first_lines(buf)
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local first_nonempty = 1
      while first_nonempty < #lines and lines[first_nonempty] == "" do
        first_nonempty = first_nonempty + 1
      end
      vim.api.nvim_buf_set_lines(buf, 0, first_nonempty - 1, false, {})
    end

    local function update_trailspace_disable(buf)
      local buf_options = vim.bo[buf]
      local is_markdown = buf_options.filetype == "markdown"
      vim.b[buf].minitrailspace_disable = is_markdown or nil
      local update_highlight = MiniTrailspace.unhighlight
      if not is_markdown and buf_options.buftype == "" and buf_options.modifiable then
        update_highlight = MiniTrailspace.highlight
      end

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          vim.api.nvim_win_call(win, update_highlight)
        end
      end
    end

    local trailspace_group = vim.api.nvim_create_augroup("TrailspaceTrim", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = trailspace_group,
      pattern = "*",
      callback = function(args)
        update_trailspace_disable(args.buf)
      end,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = trailspace_group,
      callback = function(args)
        local buf_options = vim.bo[args.buf]
        if buf_options.filetype == "markdown" or buf_options.buftype ~= "" or not buf_options.modifiable then
          return
        end

        vim.api.nvim_buf_call(args.buf, function()
          vim.cmd("silent lua MiniTrailspace.trim()")
          MiniTrailspace.trim_last_lines()
          trim_first_lines(args.buf)
        end)
      end,
    })

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        update_trailspace_disable(buf)
      end
    end
  end,
}
