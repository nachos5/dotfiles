version = "0.21.5"

local home = os.getenv("HOME")
package.path = home .. "/.config/xplr/plugins/?/init.lua;" .. home .. "/.config/xplr/plugins/?.lua;" .. package.path

-- https://xplr.dev/en/general-config
xplr.config.general.show_hidden = true

-- https://github.com/sayanarijit/fzf.xplr
require("fzf").setup({
  mode = "default",
  key = "ctrl-f",
  recursive = true,
})

-- https://github.com/sayanarijit/preview-tabbed.xplr
require("preview-tabbed").setup({
  mode = "action",
  key = "P",
  fifo_path = "/tmp/xplr.fifo",
  previewer = os.getenv("HOME") .. "/.config/nnn_custom/preview_tabbed",
}) -- Type `:p` to toggle preview mode.

require("nvim-ctrl").setup({
  bin = "nvim-ctrl",
  mode = "default",
  keys = {
    ["ctrl-e"] = "tabedit",
    ["e"] = "e",
  },
})

-- Type `yy` to copy and `p` to paste whole files.
-- Type `yp` to copy the paths of focused or selected files.
-- Type `yP` to copy the parent directory path.
require("xclip").setup({
  copy_command = "xclip-copyfile",
  copy_paths_command = "xclip -sel clip",
  paste_command = "xclip-pastefile",
  keep_selection = false,
})

xplr.config.general.initial_sorting = {
  { sorter = "ByCanonicalIsDir", reverse = true },
  { sorter = "ByCanonicalLastModified", reverse = true },
}

-- Add custom z command mode.
xplr.config.modes.custom.z_input = {
  name = "z input",
  prompt = "z> ",
  key_bindings = {
    on_key = {
      enter = {
        help = "execute z",
        messages = {
          { CallLuaSilently = "custom.z_handler" },
          "PopMode",
        },
      },
      esc = {
        help = "cancel",
        messages = {
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}

-- Add z key binding to default mode.
xplr.config.modes.builtin.default.key_bindings.on_key.z = {
  help = "z jump",
  messages = {
    "PopMode",
    { SwitchModeCustom = "z_input" },
    { SetInputBuffer = "" },
  },
}

-- Add z handler function.
xplr.fn.custom.z_handler = function(app)
  local new_path =
    io.popen("bash -c 'source ~/z.sh && _z 2>&1 " .. app.input_buffer .. " && pwd'"):read("*a"):gsub("[\n\r]", "")
  if new_path ~= "" then
    return {
      { ChangeDirectory = new_path },
      "ExplorePwdAsync",
    }
  end
end

-- Add custom cd command mode.
xplr.config.modes.custom.cd_input = {
  name = "cd input",
  prompt = "cd> ",
  key_bindings = {
    on_key = {
      enter = {
        help = "execute cd",
        messages = {
          { CallLuaSilently = "custom.cd_handler" },
          "PopMode",
        },
      },
      esc = {
        help = "cancel",
        messages = {
          "PopMode",
        },
      },
    },
    default = {
      messages = {
        "UpdateInputBufferFromKey",
      },
    },
  },
}

-- Add cd key binding to default mode.
xplr.config.modes.builtin.default.key_bindings.on_key.x = {
  help = "cd to path",
  messages = {
    "PopMode",
    { SwitchModeCustom = "cd_input" },
    { SetInputBuffer = "" },
  },
}

-- Add cd handler function.
xplr.fn.custom.cd_handler = function(app)
  local path = app.input_buffer
  -- Expand tilde to home directory
  if path:sub(1, 1) == "~" then
    path = os.getenv("HOME") .. path:sub(2)
  end

  -- Check if the path exists
  local exists = io.popen("test -d '" .. path .. "' && echo 'yes' || echo 'no'"):read("*a"):gsub("[\n\r]", "")

  if exists == "yes" then
    return {
      { ChangeDirectory = path },
      "ExplorePwdAsync",
    }
  else
    return {
      { LogError = "Directory does not exist: " .. path },
    }
  end
end
