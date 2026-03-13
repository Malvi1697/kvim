return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false,
  build = 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'MeanderingProgrammer/render-markdown.nvim',
  },
  opts = {
    provider = 'copilot',
  },
}
