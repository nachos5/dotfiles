local methods = require("null-ls.methods")
local helpers = require("null-ls.helpers")

local FORMATTING = methods.internal.FORMATTING

return helpers.make_builtin({
  name = "sleek",
  method = FORMATTING,
  filetypes = { "sql" },
  generator_opts = {
    command = "sleek",
    args = { "$FILENAME" },
    to_temp_file = true,
    from_temp_file = true,
  },
  factory = helpers.formatter_factory,
})
