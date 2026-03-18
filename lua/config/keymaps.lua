local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = 'Show all keymaps' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
map('t', '<C-l>', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })
map('t', '<C-j>', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
map('t', '<C-k>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<leader>tt', '<cmd>terminal<CR>', { desc = 'Terminal in current window' })
map('n', '<leader>ts', '<cmd>split | terminal<CR>', { desc = 'Terminal in horizontal split' })
map('n', '<leader>tv', '<cmd>vsplit | terminal<CR>', { desc = 'Terminal in vertical split' })
map('t', '<M-CR>', function()
  vim.api.nvim_chan_send(vim.bo.channel, '\x1b[13;2u')
end, { desc = 'Newline in Claude CLI (Option+Enter)' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map({ 'n', 't' }, '<A-h>', '5<C-w><', { desc = 'Resize split narrower' })
map({ 'n', 't' }, '<A-l>', '5<C-w>>', { desc = 'Resize split wider' })
map({ 'n', 't' }, '<A-j>', '5<C-w>-', { desc = 'Resize split shorter' })
map({ 'n', 't' }, '<A-k>', '5<C-w>+', { desc = 'Resize split taller' })
map('n', '<D-/>', 'gcc', { remap = true, desc = 'Toggle comment' })
map('v', '<D-/>', 'gc', { remap = true, desc = 'Toggle comment' })

-- Splits
map('n', '<leader>sh', '<cmd>new<CR>', { desc = 'Horizontal split (empty)' })
map('n', '<leader>sv', '<cmd>vnew<CR>', { desc = 'Vertical split (empty)' })

map('n', 's', '<cmd>HopWord<cr>')
map('n', 'S', '<cmd>HopLine<cr>')

map('n', '\\', '<C-o>', { desc = 'Jump back to previous location' })
map('n', '|', '<C-i>', { desc = 'Jump forward to next location' })
map('n', '<C-o>', '<Nop>')
map('n', '<C-i>', '<Nop>')

map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP Hover' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto definition' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'Goto references' })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
map('n', 'D', vim.diagnostic.open_float, { desc = 'Show diagnostic' })

map('i', '<Tab>', function()
  local suggestion = require 'copilot.suggestion'
  if suggestion.is_visible() then
    suggestion.accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
  end
end, { desc = 'Accept Copilot or Tab' })

