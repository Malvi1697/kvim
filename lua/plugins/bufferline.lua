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
          vim.cmd('bdelete! ' .. cur)
        else
          -- Last buffer, just close the window
          vim.cmd('close')
        end
      end,
      desc = 'Close tab',
    },
  },
  config = function()
    local function get_bg()
      local bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
      if bg then
        return string.format('#%06x', bg)
      end
    end

    local function setup_bufferline()
      local bg = get_bg()
      require('bufferline').setup {
        options = {
          diagnostics = 'nvim_lsp',
          always_show_bufferline = false,
          show_close_icon = false,
        },
        highlights = bg and {
          fill = { bg = bg },
        } or {},
      }
    end

    setup_bufferline()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = setup_bufferline,
    })
  end,
}
