return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Extended textobjects: ia (argument), if (function), etc.
      require('mini.ai').setup()

      -- Toggle single-line ↔ multi-line (gS)
      require('mini.splitjoin').setup()
    end,
  },
}
