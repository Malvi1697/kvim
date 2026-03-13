vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python' },
  command = 'setlocal shiftwidth=4 tabstop=4',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },
  command = 'setlocal shiftwidth=4 tabstop=4 noexpandtab',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Set filetype to htmldjango for HTML files in templates/ directories',
  pattern = { '*/templates/*.html', '*/templates/**/*.html' },
  command = 'setlocal filetype=htmldjango',
})

-- Sync indent guides to shiftwidth per buffer
vim.api.nvim_create_autocmd({ 'FileType', 'OptionSet' }, {
  pattern = { '*', 'shiftwidth' },
  callback = function()
    local sw = vim.bo.shiftwidth
    if sw > 0 then
      vim.opt_local.listchars:append { leadmultispace = '▏' .. string.rep(' ', sw - 1) }
    end
  end,
})

-- Bright split separators (survives colorscheme changes)
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('bright-separators', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#565f89', bold = true })
  end,
})
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#565f89', bold = true })

-- Cursorline only in focused split
local focus_group = vim.api.nvim_create_augroup('focus-active-window', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  group = focus_group,
  callback = function() vim.wo.cursorline = true end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = focus_group,
  callback = function() vim.wo.cursorline = false end,
})

