return {
  'greggh/claude-code.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude Code' },
    { '<leader>aC', '<cmd>ClaudeCodeDangerous<cr>', desc = 'Toggle Claude Code (skip permissions)' },
  },
  opts = {
    window = {
      position = 'vertical botright',
      split_ratio = 0.4,
    },
    command_variants = {
      dangerous = '--dangerously-skip-permissions',
    },
    keymaps = {
      toggle = {
        variants = {
          dangerous = '<leader>aC',
        },
      },
    },
  },
}
