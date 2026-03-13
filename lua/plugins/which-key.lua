return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'hunk' },
      { '<leader>s', group = 'search' },
    },
  },
}
