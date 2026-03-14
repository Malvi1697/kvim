local claude_term

return {
  'akinsho/toggleterm.nvim',
  keys = {
    {
      '<leader>ac',
      function()
        if not claude_term then
          claude_term = require('toggleterm.terminal').Terminal:new({
            cmd = 'claude',
            direction = 'vertical',
            on_open = function()
              vim.cmd('startinsert!')
              vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.4))
            end,
          })
        end
        claude_term:toggle()
      end,
      desc = 'Toggle Claude Code',
    },
  },
}
