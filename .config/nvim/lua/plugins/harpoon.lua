return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local nnoremap = require("keymap").nnoremap
    local silent = { silent = true }

    nnoremap("<leader>ha", function()
      harpoon:list():add()
    end, silent)
    nnoremap("<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, silent)

    for i = 1, 9 do
      nnoremap("<leader>" .. i, function()
        harpoon:list():select(i)
      end, silent)
    end
  end,
}
