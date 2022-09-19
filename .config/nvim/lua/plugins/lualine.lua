local function scstatus()
  if vim.bo.filetype == "supercollider" then
    stat = vim.fn["scnvim#statusline#server_status"]()
    stat = stat:gsub("%%", "♪")
    return stat
  else
    return ""
  end
end

require("lualine").setup({
  sections = {
    lualine_c = { "filename", scstatus },
  },
  extensions = { "nvim-tree", "toggleterm" },
})
