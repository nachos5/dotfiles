return {
  "ThePrimeagen/harpoon",
  config = function()
    local nnoremap = require("keymap").nnoremap

    local silent = { silent = true }

    require("harpoon").setup()

    nnoremap("<leader>ha", function()
      require("harpoon.mark").add_file()
    end, silent)
    nnoremap("<leader>hh", function()
      require("harpoon.ui").toggle_quick_menu()
    end, silent)
    nnoremap("<leader>1", function()
      require("harpoon.ui").nav_file(1)
    end, silent)
    nnoremap("<leader>2", function()
      require("harpoon.ui").nav_file(2)
    end, silent)
    nnoremap("<leader>3", function()
      require("harpoon.ui").nav_file(3)
    end, silent)
    nnoremap("<leader>4", function()
      require("harpoon.ui").nav_file(4)
    end, silent)
    nnoremap("<leader>5", function()
      require("harpoon.ui").nav_file(5)
    end, silent)
    nnoremap("<leader>6", function()
      require("harpoon.ui").nav_file(6)
    end, silent)
    nnoremap("<leader>7", function()
      require("harpoon.ui").nav_file(7)
    end, silent)
    nnoremap("<leader>8", function()
      require("harpoon.ui").nav_file(8)
    end, silent)
    nnoremap("<leader>9", function()
      require("harpoon.ui").nav_file(9)
    end, silent)
  end,
}
