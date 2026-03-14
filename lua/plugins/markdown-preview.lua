return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = 'markdown',
  build = 'cd app && npm install',
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreview<CR>', desc = 'Markdown preview' },
    { '<leader>mP', '<cmd>MarkdownPreviewStop<CR>', desc = 'Markdown preview stop' },
  },
}
