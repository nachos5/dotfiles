-- @diff: @staged: @file:
return {
  "dlants/magenta.nvim",
  lazy = false,
  build = "npm install --frozen-lockfile",
  config = function()
    -- https://github.com/dlants/magenta.nvim/issues/169
    require("magenta.keymaps").default_keymaps = function() end

    require("magenta").setup({
      profiles = {
        {
          name = "claude-opus",
          provider = "anthropic",
          model = "claude-opus-4-5",
          fastModel = "claude-haiku-4-5",
          apiKeyEnvVar = "CLAUDE_API_KEY",
        },
        {
          name = "gpt-5",
          provider = "openai",
          model = "gpt-5",
          fastModel = "gpt-5-mini",
          apiKeyEnvVar = "OPENAI_API_KEY",
        },
      },
      sidebarPosition = "right",
      picker = "telescope",
      defaultKeymaps = false,
      customCommands = {
        {
          name = "@nedit",
          text = "DO NOT MAKE ANY EDITS TO CODE. Do not use any tools that allow you to edit code. Do not execute bash commands which edit code. NO EDITING WHATSOEVER OR ELSE.",
          description = "Disable all code editing functionality",
        },
        {
          name = "@careful",
          text = "Be extra careful and double-check your work before making any changes.",
          description = "Request extra caution",
        },
        {
          name = "@perf",
          text = "Focus on performance optimization. Profile the code and suggest improvements for speed and memory usage.",
          description = "Performance optimization focus",
        },
        {
          name = "@plan",
          text = "Make a plan.",
          description = "Planning",
        },
      },
      chimeVolume = 0.0,
    })

    local Actions = require("magenta.actions")

    vim.keymap.set(
      "n",
      "<leader>mn",
      ":Magenta new-thread<CR>",
      { silent = true, noremap = true, desc = "Create new Magenta thread" }
    )

    vim.keymap.set(
      "n",
      "<leader>mc",
      ":Magenta clear<CR>",
      { silent = true, noremap = true, desc = "Clear Magenta state" }
    )

    vim.keymap.set(
      "n",
      "<leader>ma",
      ":Magenta abort<CR>",
      { silent = true, noremap = true, desc = "Abort current Magenta operation" }
    )

    vim.keymap.set(
      "n",
      "<leader>mt",
      ":Magenta toggle<CR>",
      { silent = true, noremap = true, desc = "Toggle Magenta window" }
    )

    vim.keymap.set(
      "n",
      "<leader>mi",
      ":Magenta start-inline-edit<CR>",
      { silent = true, noremap = true, desc = "Inline edit" }
    )

    vim.keymap.set(
      "v",
      "<leader>mi",
      ":Magenta start-inline-edit-selection<CR>",
      { silent = true, noremap = true, desc = "Inline edit selection" }
    )

    -- vim.keymap.set(
    --   "v",
    --   "<leader>mp",
    --   ":Magenta paste-selection<CR>",
    --   { silent = true, noremap = true, desc = "Send selection to Magenta" }
    -- )

    vim.keymap.set(
      "n",
      "<leader>mr",
      ":Magenta replay-inline-edit<CR>",
      { silent = true, noremap = true, desc = "Replay last inline edit" }
    )

    vim.keymap.set(
      "v",
      "<leader>mr",
      ":Magenta replay-inline-edit-selection<CR>",
      { silent = true, noremap = true, desc = "Replay last inline edit on selection" }
    )

    vim.keymap.set(
      "n",
      "<leader>m.",
      ":Magenta replay-inline-edit<CR>",
      { silent = true, noremap = true, desc = "Replay last inline edit" }
    )

    vim.keymap.set(
      "v",
      "<leader>m.",
      ":Magenta replay-inline-edit-selection<CR>",
      { silent = true, noremap = true, desc = "Replay last inline edit on selection" }
    )

    vim.keymap.set(
      "n",
      "<leader>mb",
      Actions.add_buffer_to_context,
      { noremap = true, silent = true, desc = "Add current buffer to Magenta context" }
    )

    vim.keymap.set(
      "n",
      "<leader>mf",
      Actions.pick_context_files,
      { noremap = true, silent = true, desc = "Select files to add to Magenta context" }
    )
  end,
}
