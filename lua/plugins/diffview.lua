return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git diff view (source control)' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Git branch history' },
  },
  opts = {
    keymaps = {
      view = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        { 'n', 'gf', function() require('diffview.actions').goto_file_edit() end, { desc = 'Open file' } },
      },
      file_panel = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        { 'n', 'gf', function() require('diffview.actions').goto_file_edit() end, { desc = 'Open file' } },
      },
      file_history_panel = {
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        { 'n', 'gf', function() require('diffview.actions').goto_file_edit() end, { desc = 'Open file' } },
      },
    },
  },
}
