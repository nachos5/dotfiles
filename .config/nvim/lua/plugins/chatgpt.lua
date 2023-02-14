local nnoremap = require("keymap").nnoremap

local has_openai_api_key = vim.env.OPENAI_API_KEY ~= nil

if has_openai_api_key then
  require("chatgpt").setup({})

  nnoremap("<leader>cg", ":ChatGPT<CR>", { silent = true })
end
