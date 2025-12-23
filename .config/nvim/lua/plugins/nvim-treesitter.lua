-- :TSInstall all
-- :InspectTree
-- cargo install --locked tree-sitter-cli

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  lazy = false,
  dependencies = {
    {
      "hiphish/rainbow-delimiters.nvim",
      config = function()
        local rainbow_delimiters = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
          strategy = {
            [""] = rainbow_delimiters.strategy["global"],
            vim = rainbow_delimiters.strategy["local"],
          },
          query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
          },
          highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        }
      end,
    },
    -- Automatically add closing tags for HTML and JSX.
    { "windwp/nvim-ts-autotag", opts = {} },
  },
  config = function()
    local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

    require("nvim-treesitter").setup({
      ensure_installed = {
        "core",
        "stable",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "c",
        "cpp",
        "markdown",
        "markdown_inline",
        "csv",
        "json",
      },
      auto_install = true,
    })

    -- autocmd for highlighting.
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        local bufnr = args.buf
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
          return
        end

        if vim.api.nvim_buf_line_count(bufnr) > 5000 then
          -- Large files, no treesitter highlighting and disable basic highlighting.
          vim.schedule(function()
            vim.bo[bufnr].syntax = "off"
          end)
        else
          -- Start treesitter.
          pcall(vim.treesitter.start)
        end
      end,
    })
  end,
}
