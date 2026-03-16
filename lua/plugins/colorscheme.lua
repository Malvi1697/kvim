return {
  -- Jetdark theme (JetBrains-inspired)
  {
    dir = '/Users/janvseticek/work/personal/jetdark.nvim',
    name = 'jetdark',
    priority = 1000,
  },

  -- Tokyo Night theme + colorscheme persistence
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        styles = { comments = { italic = false } },
      }

      local themefile = vim.fn.stdpath 'data' .. '/last_colorscheme'

      local function safe_colorscheme(name)
        local ok = pcall(vim.cmd.colorscheme, name)
        if not ok then
          vim.notify('Failed to load colorscheme: ' .. name, vim.log.levels.WARN)
        end
      end

      safe_colorscheme 'jetdark'
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyDone',
        once = true,
        callback = function()
          if vim.fn.filereadable(themefile) == 1 then
            local last = vim.fn.readfile(themefile)[1]
            safe_colorscheme(last)
          end
        end,
      })

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          local name = vim.g.colors_name
          if name then
            vim.fn.writefile({ name }, themefile)
          end
        end,
      })
    end,
  },
}
