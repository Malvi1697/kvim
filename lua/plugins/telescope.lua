return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    telescope.setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = { '--hidden' },
        },
        colorscheme = {
          enable_preview = true, -- 👈 this makes live preview work
        },
      },
    }
    telescope.load_extension 'ui-select'

    local map = vim.keymap.set
    map('n', '<leader>sf', builtin.find_files, { desc = 'Find files' })
    map('n', '<leader>sg', telescope.extensions.live_grep_args.live_grep_args, { desc = 'Grep text' })
    map('n', '<leader>sG', function()
      local glob = vim.fn.input 'File glob: '
      if glob ~= '' then
        builtin.live_grep { glob_pattern = glob }
      end
    end, { desc = 'Grep text (filtered by glob)' })
    map('n', '<leader>sb', builtin.buffers, { desc = 'Buffers' })
    map('n', '<leader>sH', builtin.help_tags, { desc = 'Help' })
    map('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
    map('n', '<leader>so', builtin.oldfiles, { desc = 'Recent (old) files' })
  end,
}
