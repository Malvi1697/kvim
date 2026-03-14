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

-- Autosave on focus loss or buffer leave
vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave', 'FocusLost' }, {
  group = vim.api.nvim_create_augroup('autosave', { clear = true }),
  callback = function()
    if vim.bo.modified and vim.bo.buftype == '' and vim.fn.expand('%') ~= '' then
      vim.cmd('silent! write')
    end
  end,
})

-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  group = vim.api.nvim_create_augroup('auto-reload', { clear = true }),
  command = 'silent! checktime',
})

-- Dim unfocused windows + cursorline only in focused split
local focus_group = vim.api.nvim_create_augroup('focus-active-window', { clear = true })

local function set_dim_hl()
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
  local bg = normal.bg or 0x1a1b26
  -- Blend 15% toward black
  local r = math.floor(bit.rshift(bg, 16) * 0.85)
  local g = math.floor(bit.band(bit.rshift(bg, 8), 0xFF) * 0.85)
  local b = math.floor(bit.band(bg, 0xFF) * 0.85)
  vim.api.nvim_set_hl(0, 'DimmedNormal', { bg = bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b) })
end

set_dim_hl()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = focus_group,
  callback = set_dim_hl,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  group = focus_group,
  callback = function()
    vim.wo.cursorline = true
    vim.wo.winhighlight = ''
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = focus_group,
  callback = function()
    vim.wo.cursorline = false
    vim.wo.winhighlight = 'Normal:DimmedNormal'
  end,
})

