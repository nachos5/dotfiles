-- Notebook setup: https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md
-- Remote: https://github.com/benlubas/molten-nvim/blob/main/docs/Advanced-Functionality.md
return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  lazy = false,
  dependencies = {
    "3rd/image.nvim",
    {
      "quarto-dev/quarto-nvim",
      dependencies = {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("quarto").setup({
          codeRunner = {
            enabled = true,
            default_method = "molten", -- "molten", "slime", "iron" or <function>
            ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
            -- Takes precedence over `default_method`
            never_run = { "yaml" }, -- filetypes which are never sent to a code runner
          },
        })
      end,
    },
    {
      "GCBallesteros/jupytext.nvim",
      config = function()
        require("jupytext").setup({
          style = "markdown",
          output_extension = "md",
          force_ft = "markdown",
        })
      end,
    },
  },
  build = ":UpdateRemotePlugins",
  config = function()
    -- vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_image_provider = "wezterm"
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
    vim.g.molten_auto_image_popup = true
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_lines_off_by_1 = true

    vim.keymap.set("n", "<localleader>ji", ":MoltenInit<CR>")
    vim.keymap.set("n", "<localleader>je", ":MoltenEvaluateOperator<CR>")
    vim.keymap.set("n", "<localleader>jl", ":MoltenEvaluateLine<CR>")
    vim.keymap.set("n", "<localleader>jr", ":MoltenReevaluateCell<CR>")
    vim.keymap.set("v", "<localleader>jr", ":<C-u>MoltenEvaluateVisual<CR>gv")
    vim.keymap.set("n", "<localleader>jo", ":noautocmd MoltenEnterOutput<CR>")
    vim.keymap.set("n", "<localleader>jh", ":MoltenHideOutput<CR>")
    vim.keymap.set("n", "<localleader>jd", ":MoltenDelete<CR>")

    -- Provide a command to create a blank new Python notebook
    -- note: the metadata is needed for Jupytext to understand how to parse the notebook.
    -- if you use another language than Python, you should change it in the template.
    local default_notebook = [[
      {
        "cells": [
         {
          "cell_type": "markdown",
          "metadata": {},
          "source": [
            ""
          ]
         }
        ],
        "metadata": {
         "kernelspec": {
          "display_name": "Python 3",
          "language": "python",
          "name": "python3"
         },
         "language_info": {
          "codemirror_mode": {
            "name": "ipython"
          },
          "file_extension": ".py",
          "mimetype": "text/x-python",
          "name": "python",
          "nbconvert_exporter": "python",
          "pygments_lexer": "ipython3"
         }
        },
        "nbformat": 4,
        "nbformat_minor": 5
      }
    ]]

    local function new_notebook(filename)
      local path = filename .. ".ipynb"
      local file = io.open(path, "w")
      if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
      else
        print("Error: Could not open new notebook file for writing.")
      end
    end

    vim.api.nvim_create_user_command("NewNotebook", function(opts)
      new_notebook(opts.args)
    end, {
      nargs = 1,
      complete = "file",
    })
  end,
}
