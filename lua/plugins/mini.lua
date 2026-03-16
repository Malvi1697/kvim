return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Toggle single-line ↔ multi-line (gS)
      require('mini.splitjoin').setup()
    end,
  },
}
