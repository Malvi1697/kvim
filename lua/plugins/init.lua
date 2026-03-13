-- lua/plugins/init.lua
return {
  -- UI
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'SmiteshP/nvim-navic' },
    opts = {
      winbar = {
        lualine_c = {
          { 'navic', color_correction = 'static' },
        },
      },
    },
  },

  -- File explorer
  { import = 'plugins.neo-tree' },

  -- Navigation & Search
  { import = 'plugins.telescope' },
  { import = 'plugins.hop' },
  { import = 'plugins.which-key' },

  -- Syntax & Treesitter
  { import = 'plugins.treesitter' },

  -- Completion & Snippets
  { import = 'plugins.cmp' },
  { import = 'plugins.autopairs' },
  { import = 'plugins.surround' },

  -- LSP & Tools
  { import = 'plugins.mason' },
  { import = 'plugins.formatting' },
  { import = 'plugins.lint' },

  -- Git
  { import = 'plugins.gitsigns' },
  { import = 'plugins.lazygit' },
  { import = 'plugins.diffview' },

  -- AI
  { import = 'plugins.copilot' },
  { import = 'plugins.claude' },
  { import = 'plugins.avante' },

  -- Themes & Appearance
  { import = 'plugins.colorscheme' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.navic' },
  { import = 'plugins.render-markdown' },

  -- Terminal
  { import = 'plugins.toggleterm' },

  -- Session
  { import = 'plugins.persistence' },

  -- Debugging
  { import = 'plugins.debug' },
}
