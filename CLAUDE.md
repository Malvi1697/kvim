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

## Installed Plugins

| Category | Plugin | Purpose | Config file |
|----------|--------|---------|-------------|
| UI | nvim-tree/nvim-web-devicons | File icons | init.lua (inline) |
| UI | nvim-lualine/lualine.nvim | Status line | init.lua (inline) |
| UI | SmiteshP/nvim-navic | Winbar breadcrumbs | navic.lua |
| File Explorer | nvim-tree/nvim-tree.lua | File tree (+ nvim-window-picker) | nvim-tree.lua |
| Navigation | nvim-telescope/telescope.nvim | Fuzzy finder (+ fzf-native, ui-select, live-grep-args) | telescope.lua |
| Navigation | smoka7/hop.nvim | Easymotion-like jumps | hop.lua |
| Navigation | folke/which-key.nvim | Key binding display | which-key.lua |
| Navigation | nvim-pack/nvim-spectre | Search & replace | spectre.lua |
| Treesitter | nvim-treesitter/nvim-treesitter | Syntax parsing (+ textobjects) | treesitter.lua |
| Completion | hrsh7th/nvim-cmp | Completion engine (+ luasnip, cmp-lsp, cmp-buffer, cmp-path) | cmp.lua |
| Completion | windwp/nvim-autopairs | Auto-close brackets | autopairs.lua |
| Completion | kylechui/nvim-surround | Surround text objects | surround.lua |
| LSP & Tools | mason-org/mason.nvim | LSP/formatter/linter installer | mason.lua |
| LSP & Tools | stevearc/conform.nvim | Formatting | formatting.lua |
| LSP & Tools | mfussenegger/nvim-lint | Linting | lint.lua |
| Git | lewis6991/gitsigns.nvim | Git signs & hunk ops | gitsigns.lua |
| Git | akinsho/toggleterm.nvim | LazyGit terminal | lazygit.lua |
| Git | sindrets/diffview.nvim | Diff viewer | diffview.lua |
| AI | zbirenbaum/copilot.lua | GitHub Copilot | copilot.lua |
| AI | akinsho/toggleterm.nvim | Claude Code terminal | claude.lua |
| Mini | echasnovski/mini.nvim | ai, splitjoin modules | mini.lua |
| Tabs | akinsho/bufferline.nvim | Buffer/tab line | bufferline.lua |
| Themes | folke/tokyonight.nvim | Theme (with persistence) | colorscheme.lua |
| Themes | catppuccin/nvim, gruvbox, rose-pine, nightfox, material, kanagawa, kanagawa-paper, ayu, darcula, onedark, nordic, teide, jetdark (local) | 14 colorschemes | colorscheme.lua |
| Themes | folke/todo-comments.nvim | Highlight TODO/FIXME | todo-comments.lua |
| Themes | MeanderingProgrammer/render-markdown.nvim | Markdown rendering | render-markdown.lua |
| Themes | iamcco/markdown-preview.nvim | Browser markdown preview | markdown-preview.lua |
| Terminal | akinsho/toggleterm.nvim | Floating terminal | toggleterm.lua |
| Session | folke/persistence.nvim | Session save/restore | persistence.lua |
| Debugging | mfussenegger/nvim-dap | DAP client (+ dap-ui, dap-go, mason-nvim-dap) | debug.lua |

## Colorscheme

14 themes installed. Default is `jetdark`. The last selected theme is persisted to `stdpath('data')/last_colorscheme`.
