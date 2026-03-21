# AGENTS.md - Guidelines for Coding Agents

This document provides guidelines for AI coding agents working in this dotfiles repository.

## Project Overview

This is a dotfiles repository containing configuration files for:

- **Neovim** (Lua-based configuration)
- **i3** window manager
- **tmux** terminal multiplexer
- **wezterm** terminal emulator
- **xplr** file manager
- **Various shell scripts and aliases**

## Build/Lint/Test Commands

### Pre-commit (Primary Linting Tool)

```bash
# Install pre-commit hooks (one-time setup)
pre-commit install

# Run all pre-commit hooks on all files
pre-commit run -a
```

## Code Style Guidelines

### Lua (Neovim Configuration)

**Formatting** (enforced by stylua):

- Column width: 120 characters
- Indent: 2 spaces
- Quote style: AutoPreferDouble (prefer double quotes)
- Call parentheses: Always
- Line endings: Unix (LF)

**Naming Conventions**:

- Use `snake_case` for variables and functions
- Use `PascalCase` for module tables returned from files
- Local variables at top of file: `local module = {}`

**Module Pattern**:

```lua
-- Import modules
local ls = require("luasnip")
local s = ls.snippet

-- Define module contents
local my_module = {
  key = "value",
}

-- Return the module
return my_module
```

## File Organization

### Neovim Configuration Structure

```
.config/nvim/
├── init.lua           # Entry point, requires all modules
├── lua/
│   ├── globals.lua    # Global variables
│   ├── set.lua        # Vim options
│   ├── plugins.lua    # Plugin specifications
│   ├── lsp.lua        # LSP configuration
│   ├── keymap.lua     # Keymap utilities
│   ├── mappings/      # Key mappings (subdirectory)
│   │   ├── init.lua
│   │   └── ...
│   └── plugins/       # Plugin configurations (subdirectory)
│       ├── lsp.lua
│       └── ...
```

### Import Pattern

```lua
-- In init.lua
require("module_name")

-- For subdirectories
require("mappings/init")  -- or just require("mappings")
require("plugins/lsp")
```

## Common Patterns

### Plugin Specification (lazy.nvim)

```lua
return {
  "author/plugin-name",
  dependencies = { "dep/plugin" },
  config = function()
    -- configuration
  end,
}
```

### LSP Configuration

```lua
vim.lsp.config("server_name", {
  settings = {
    -- server-specific settings
  },
})
```

### Shell Aliases

```bash
# Simple aliases
alias ll='ls -alF'

# Functions for complex operations
portarg() {
    sudo lsof -i:"$1"
    sudo lsof -tnP -i:"$1" | xargs -n 1 ps -p
}
```

## Important Notes

1. **No Tests**: This is a configuration repository; there are no automated tests.

2. **Pre-commit Hooks**: All changes must pass pre-commit hooks. Run `pre-commit run -a` before committing.

3. **Symlinks**: The `install.sh` script creates symlinks from the repository to the home directory.
