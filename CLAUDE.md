# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

kvim is a personal Neovim configuration based on kickstart.nvim. It supports Lua, Python, JavaScript, TypeScript, Vue/Nuxt, and Django development.

## Architecture

```
init.lua                    → requires core.lazy (single entry point)
lua/core/lazy.lua           → bootstraps lazy.nvim, then loads config/*
lua/config/options.lua      → vim options (leader=Space, 2-space indent default)
lua/config/keymaps.lua      → all keybindings
lua/config/autocmds.lua     → autocommands (yank highlight, filetype indents, Django template detection)
lua/config/lsp.lua          → vim.lsp.enable list
lua/plugins/init.lua        → imports all plugin specs (auto-discovered by lazy)
lua/plugins/*.lua           → individual plugin configurations
lsp/*.lua                   → LSP server configs (return a vim.lsp.Config table)
```

**Load order**: options.lua → lazy.setup (plugins) → autocmds.lua → keymaps.lua → lsp.lua

## Key Conventions

- **LSP configs** go in `lsp/<server_name>.lua` and must return a `vim.lsp.Config` table with `cmd`, `filetypes`, `root_markers`, and optionally `settings`/`on_attach`. Then add the server name to `vim.lsp.enable` in `lua/config/lsp.lua`.
- **Plugin configs** go in `lua/plugins/<name>.lua` as lazy.nvim spec tables. Add a corresponding `{ import = 'plugins.<name>' }` entry in `lua/plugins/init.lua`.
- **Formatting** is handled by conform.nvim (`lua/plugins/formatting.lua`) — add formatters to `formatters_by_ft`.
- **Linting** is handled by nvim-lint (`lua/plugins/lint.lua`) — add linters to `linters_by_ft`.
- **Treesitter parsers** are listed in `ensure_installed` in `lua/plugins/treesitter.lua`.
- **Indentation overrides** per filetype go in `lua/config/autocmds.lua` (Python/Go=4 spaces, default=2 spaces).

## Current Language Support

| Language | LSP | Formatter | Linter |
|----------|-----|-----------|--------|
| Lua | luals | stylua | — |
| Python | pyright | ruff_format | — |
| JS/TS | ts_ls | prettierd/prettier | eslint_d |
| Vue | vue_ls | prettierd/prettier | eslint_d |
| HTML/CSS/JSON | — | prettierd/prettier | — |
| Go | gopls | goimports, gofumpt | — |
| Django templates | — (htmldjango filetype auto-detected) | — | — |

## Tool Installation

LSP servers, formatters, and linters are installed via Mason (`:Mason` inside nvim). They are not bundled in this repo.

## Colorscheme

13 themes installed. Default is `tokyonight-night`. The last selected theme is persisted to `stdpath('data')/last_colorscheme`.
