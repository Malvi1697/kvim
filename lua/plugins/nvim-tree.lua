return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle file explorer', silent = true },
    { '<leader>r', ':NvimTreeFindFile<CR>', desc = 'Locate file in explorer', silent = true },
  },
  opts = {
    view = {
      width = 50,
    },
  },
}
