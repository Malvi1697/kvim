local float_scale = 0.85

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-\\>', desc = 'Toggle terminal' },
  },
  opts = {
    open_mapping = '<C-\\>',
    direction = 'float',
    float_opts = {
      border = 'curved',
      width = function()
        return math.floor(vim.o.columns * float_scale)
      end,
      height = function()
        return math.floor(vim.o.lines * float_scale)
      end,
    },
  },
}
