return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function scstatus()
      if vim.bo.filetype == "supercollider" then
        local stat = vim.fn["scnvim#statusline#server_status"]()
        stat = stat:gsub("%%", "♪")
        return stat
      else
        return ""
      end
    end

    local function scope()
      local scopes = require("neoscopes")
      if scopes.get_current_scope() then
        return "scope: " .. scopes.get_current_scope().name
      else
        return ""
      end
    end

    require("lualine").setup({
      sections = {
        lualine_b = { "branch", "diff", "diagnostics", "FugitiveHead" },
        lualine_c = { "filename", scstatus, scope },
      },
      extensions = { "nvim-tree", "toggleterm" },
    })
  end,
}
