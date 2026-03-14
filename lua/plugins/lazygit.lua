local float_opts = {
  border = 'curved',
  width = function() return math.floor(vim.o.columns * 0.85) end,
  height = function() return math.floor(vim.o.lines * 0.85) end,
}

local lazygit, lazyglab

return {
  'akinsho/toggleterm.nvim',
  keys = {
    {
      '<leader>lg',
      function()
        if not lazygit then
          lazygit = require('toggleterm.terminal').Terminal:new({
            cmd = 'lazygit',
            direction = 'float',
            float_opts = float_opts,
            on_open = function() vim.cmd('startinsert!') end,
          })
        end
        vim.cmd('silent! wa')
        lazygit:toggle()
      end,
      desc = 'LazyGit',
    },
    {
      '<leader>ll',
      function()
        if not lazyglab then
          lazyglab = require('toggleterm.terminal').Terminal:new({
            cmd = 'lazyglab',
            direction = 'float',
            float_opts = float_opts,
            on_open = function() vim.cmd('startinsert!') end,
          })
        end
        lazyglab:toggle()
      end,
      desc = 'LazyGlab',
    },
  },
}
