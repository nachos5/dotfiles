local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local flatten = vim.tbl_flatten

local custom_rg = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ["l"] = "*.lua",
      ["p"] = "*.py",
      ["j"] = "*.json",
      ["h"] = "*.html",
    }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ")

      local args = { "rg" }

      if prompt_split[1] then
        local regex = prompt_split[1]
        -- if starts with m: we use multiline
        local regex_split = vim.split(regex, "m:")
        local use_multi = false
        if regex_split[2] then
          regex = regex_split[2]
          use_multi = true
        end
        table.insert(args, "-e")
        table.insert(args, regex)
        if use_multi then
          table.insert(args, "--multiline")
          table.insert(args, "--multiline-dotall")
        end
      end

      if prompt_split[2] then
        table.insert(args, "-g")

        local pattern
        if opts.shortcuts[prompt_split[2]] then
          pattern = opts.shortcuts[prompt_split[2]]
        else
          pattern = prompt_split[2]
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      local final_prompt = flatten({
        args,
        {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      })

      -- Add search_dirs if provided
      if opts.search_dirs and #opts.search_dirs > 0 then
        for _, path in ipairs(opts.search_dirs) do
          table.insert(final_prompt, path)
        end
      else
        table.insert(final_prompt, opts.cwd)
      end

      -- print(require("utils").dump(final_prompt))
      --
      return final_prompt
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Live Grep (with shortcuts)",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

return custom_rg
