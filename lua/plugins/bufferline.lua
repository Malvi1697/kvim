return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<Tab>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
    { '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous tab' },
    {
      '<leader>x',
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        if #bufs > 1 then
          -- Switch to previous buffer, then delete the original one
          local cur = vim.api.nvim_get_current_buf()
          vim.cmd('BufferLineCyclePrev')
          vim.cmd('bdelete ' .. cur)
        else
          -- Last buffer, just close the window
          vim.cmd('close')
        end
      end,
      desc = 'Close tab',
    },
  },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      show_close_icon = false,
    },
  },
}
