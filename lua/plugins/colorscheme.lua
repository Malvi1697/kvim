return {
  -- Catppuccin theme (popular, comes in 4 flavors)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

  -- Gruvbox theme (classic retro groove)
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
  },

  -- Rose Pine theme (elegant and minimal)
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
  },

  -- Nightfox theme (nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox)
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
  },

  -- Material theme (oceanic, darker, lighter, palenight, deep ocean)
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
  },

  -- Kanagawa Paper theme
  {
    'sho-87/kanagawa-paper.nvim',
    priority = 1000,
  },

  -- Ayu theme (light, mirage, dark)
  {
    'Shatur/neovim-ayu',
    priority = 1000,
  },

  -- Kanagawa theme (wave, dragon, lotus)
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },

  -- Jetdark theme (JetBrains-inspired)
  {
    dir = '/Users/janvseticek/work/personal/jetdark.nvim',
    name = 'jetdark',
    priority = 1000,
  },

  -- Darcula theme (JetBrains-style)
  {
    'doums/darcula',
    priority = 1000,
  },

  -- Onedark theme
  {
    'joshdick/onedark.vim',
    priority = 1000,
  },

  -- Nordic theme
  {
    'AlexvZyl/nordic.nvim',
    priority = 1000,
  },

  -- Teide theme (tokyonight fork with different palette: darker, dark, dimmed, light)
  {
    'serhez/teide.nvim',
    priority = 1000,
    opts = {
      styles = { comments = { italic = false } },
    },
  },

  -- Tokyo Night theme + colorscheme persistence
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      -- Configure tokyonight
      require('tokyonight').setup {
        style = 'night',
        styles = { comments = { italic = false } },
      }

      -- File where the last used colorscheme will be stored
      local themefile = vim.fn.stdpath 'data' .. '/last_colorscheme'

      -- Apply a colorscheme safely
      local function safe_colorscheme(name)
        local ok = pcall(vim.cmd.colorscheme, name)
        if not ok then
          vim.notify('Failed to load colorscheme: ' .. name, vim.log.levels.WARN)
        end
      end

      -- Set default now, then restore saved theme after all plugins load
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

      -- Save chosen theme whenever it changes
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

