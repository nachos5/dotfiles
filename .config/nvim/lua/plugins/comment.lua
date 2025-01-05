return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    local status_ok, comment = pcall(require, "Comment")
    if not status_ok then
      return
    end

    local status_ok_1, _ = pcall(require, "lsp-inlayhints")
    if not status_ok_1 then
      return
    end

    comment.setup({
      padding = true,
      sticky = true,
      ignore = "^$", -- Ignore empty lines
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = function(ctx)
        -- For inlay hints
        local line_start = (ctx.range and ctx.range.srow or 1) - 1
        local line_end = ctx.range and ctx.range.erow or 1
        require("lsp-inlayhints.core").clear(0, line_start, line_end)

        if
          vim.bo.filetype == "typescriptreact"
          or vim.bo.filetype == "javascriptreact"
          or vim.bo.filetype == "javascript"
          or vim.bo.filetype == "typescript"
        then
          local U = require("Comment.utils")

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = {}
          if ctx.ctype == U.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location() or {}
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location() or {}
          end

          local result = require("ts_context_commentstring.internal").calculate_commentstring({
            key = type,
            location = location,
          })
          return result or vim.bo.commentstring
        end
        return vim.bo.commentstring
      end,
      post_hook = function(_) end, -- Empty function instead of nil
    })
  end,
}
