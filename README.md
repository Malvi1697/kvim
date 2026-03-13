# kvim

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), extended with AI integration, multiple colorschemes, and a modular plugin architecture.

## Requirements

- Neovim >= 0.10
- Git
- A [Nerd Font](https://www.nerdfonts.com/)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope grep)
- [fd](https://github.com/sharkdp/fd) (for Telescope file finder)
- [lazygit](https://github.com/jesseduffield/lazygit) (optional, for git UI)
- Node.js (for Copilot, Pyright, prettierd)

## Installation

```sh
git clone https://github.com/Malvi1697/kvim.git ~/.config/kvim
NVIM_APPNAME=kvim nvim
```

Lazy.nvim will auto-install all plugins on first launch.

To use `kvim` as a command, add an alias:

```sh
alias kvim='NVIM_APPNAME=kvim nvim'
```

## Project Structure

```
kvim/
├── init.lua                  # Entry point → loads core/lazy.lua
├── lua/
│   ├── core/
│   │   └── lazy.lua          # Lazy.nvim bootstrap & plugin loader
│   ├── config/
│   │   ├── options.lua       # Editor settings (leader, tabs, UI)
│   │   ├── keymaps.lua       # Key mappings
│   │   ├── autocmds.lua      # Autocommands (yank highlight, filetype indent, Django templates)
│   │   └── lsp.lua           # LSP server enablement
│   └── plugins/              # Individual plugin specs (auto-discovered by lazy.nvim)
└── lsp/                      # LSP server configs (one file per server)
```

## Keybindings

Leader key: **Space**

Press `Space` and wait to see all available bindings via which-key.

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Esc>` | n | Clear search highlight |
| `<C-h/j/k/l>` | n/t | Navigate between windows |
| `<A-h/j/k/l>` | n/t | Resize splits |
| `<Esc><Esc>` | t | Exit terminal mode |
| `<leader>e` | n | Toggle file explorer |
| `<leader>r` | n | Locate file in explorer |
| `<leader>q` | n | Open diagnostic quickfix list |
| `<leader>?` | n | Show all keymaps |
| `<leader>sh` | n | Horizontal split (empty) |
| `<leader>sv` | n | Vertical split (empty) |
| `<D-/>` | n/v | Toggle comment |

### Navigation (Hop)

| Key | Mode | Action |
|-----|------|--------|
| `s` | n | Hop to word |
| `S` | n | Hop to line |
| `f` / `F` | n/v/o | Hop to character forward / backward (current line) |
| `t` / `T` | n/v/o | Hop to before character forward / backward (current line) |
| `\` | n | Jump back (jumplist) |
| `\|` | n | Jump forward (jumplist) |

### Treesitter Text Objects

| Key | Mode | Action |
|-----|------|--------|
| `af` / `if` | v/o | Around / inside function |
| `ac` / `ic` | v/o | Around / inside class |
| `aa` / `ia` | v/o | Around / inside argument |
| `]m` / `[m` | n | Jump to next / previous function |
| `]]` / `[[` | n | Jump to next / previous class |

### Surround (nvim-surround)

| Key | Mode | Action |
|-----|------|--------|
| `ys{motion}{char}` | n | Add surround (e.g. `ysiw"` wraps word in `"`) |
| `ds{char}` | n | Delete surround (e.g. `ds"` removes `"`) |
| `cs{old}{new}` | n | Change surround (e.g. `cs"'` changes `"` to `'`) |
| `S{char}` | v | Surround selection |

### Search (Telescope)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>sf` | n | Find files |
| `<leader>sg` | n | Live grep (with args) |
| `<leader>sG` | n | Live grep (filtered by glob) |
| `<leader>sb` | n | Buffers |
| `<leader>sH` | n | Help tags |
| `<leader>sk` | n | Keymaps |
| `<leader>sr` | n | Recent files |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `D` | n | Show diagnostic float |
| `gd` | n | Go to definition |
| `gr` | n | Go to references |
| `<leader>rn` | n | Rename symbol |
| `<leader>ca` | n | Code action |

### AI

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | i | Accept Copilot suggestion (or indent) |
| `<M-]>` / `<M-[>` | i | Next / previous Copilot suggestion |
| `<leader>ac` | n | Toggle Claude Code terminal |
| `<leader>aC` | n | Toggle Claude Code (skip permissions) |

Avante.nvim is available via `:Avante` commands (uses Copilot backend).

### Terminal

| Key | Mode | Action |
|-----|------|--------|
| `<C-\>` | n/t | Toggle floating terminal |
| `<leader>ts` | n | Terminal in horizontal split |
| `<leader>tv` | n | Terminal in vertical split |
| `<M-CR>` | t | Send Shift+Enter (for Claude CLI) |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>lg` | n | Open LazyGit |
| `<leader>gd` | n | Git diff view |
| `<leader>gh` | n | Git file history |
| `<leader>gH` | n | Git branch history |
| `]c` / `[c` | n | Next / previous hunk |
| `<leader>hs` | n/v | Stage hunk |
| `<leader>hr` | n/v | Reset hunk |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hS` | n | Stage buffer |
| `<leader>hR` | n | Reset buffer |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line |
| `<leader>hd` | n | Diff against index |
| `<leader>hD` | n | Diff against last commit |
| `<leader>tb` | n | Toggle line blame |

### Debugging (DAP)

| Key | Mode | Action |
|-----|------|--------|
| `<F5>` | n | Start / continue |
| `<F1>` | n | Step into |
| `<F2>` | n | Step over |
| `<F3>` | n | Step out |
| `<F7>` | n | Toggle debug UI |
| `<leader>b` | n | Toggle breakpoint |
| `<leader>B` | n | Conditional breakpoint |

### Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` / `<C-p>` | i | Next / previous item |
| `<C-y>` | i | Confirm selection |
| `<M-Space>` | i | Trigger completion |
| `<C-e>` | i | Abort completion |

## LSP Servers

| Server | Language | Config |
|--------|----------|--------|
| `luals` | Lua | `lsp/luals.lua` |
| `pyright` | Python | `lsp/pyright.lua` |
| `ts_ls` | JS / TS | `lsp/ts_ls.lua` |
| `vue_ls` | Vue | `lsp/vue_ls.lua` |
| `gopls` | Go | `lsp/gopls.lua` |

Install servers and tools via `:Mason`.

## Formatters & Linters

| Tool | Language | Type |
|------|----------|------|
| stylua | Lua | Formatter |
| ruff_format | Python | Formatter |
| ruff | Python | Linter |
| goimports, gofumpt | Go | Formatter |
| prettierd / prettier | JS / TS / Vue / HTML / CSS / JSON | Formatter |
| eslint_d | JS / TS / Vue | Linter |
| markdownlint | Markdown | Linter |

Formatting runs on save (via conform.nvim).

## Colorschemes

13 themes included. Switch with Telescope or `:colorscheme <name>`. Your choice persists across sessions.

Available: `jetdark` (default), `tokyonight-night`, `catppuccin`, `gruvbox`, `rose-pine`, `nightfox`, `material`, `kanagawa-paper`, `ayu`, `kanagawa`, `darcula`, `onedark`, `nordic`

## License

MIT
