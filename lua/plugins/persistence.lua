return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  init = function()
    -- Before saving: delete all buffers not visible in a window
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        local visible = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          visible[vim.api.nvim_win_get_buf(win)] = true
        end
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if not visible[buf] then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end,
    })

    -- Automatically restore session for the current directory
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('persistence-autoload', { clear = true }),
      nested = true,
      callback = function()
        -- Only restore if nvim was started without file arguments
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          require('persistence').load()
          -- Always reopen nvim-tree after session restore
          vim.schedule(function()
            require('nvim-tree.api').tree.open()
          end)
        end
      end,
    })

    -- Detect stdin
    vim.api.nvim_create_autocmd('StdinReadPre', {
      group = vim.api.nvim_create_augroup('persistence-stdin', { clear = true }),
      callback = function()
        vim.g.started_with_stdin = true
      end,
    })
  end,
}
