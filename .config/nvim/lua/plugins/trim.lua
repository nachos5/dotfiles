-- Trim whitespace from ends of lines automatically
return {
  "cappyzawa/trim.nvim",
  config = function()
    require("trim").setup({
      ft_blocklist = { "markdown" },
      patterns = {
        [[%s/\s\+$//e]], -- remove unwanted spaces
        [[%s/\($\n\s*\)\+\%$//]], -- trim last line
        [[%s/\%^\n\+//]], -- trim first line
      },
    })
  end,
}
