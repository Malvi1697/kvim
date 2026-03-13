---@type vim.lsp.Config
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'nuxt.config.ts', 'nuxt.config.js', 'vue.config.js', 'package.json', '.git' },
  init_options = {
    typescript = {
      tsdk = '',
    },
    vue = {
      hybridMode = false,
    },
  },
  before_init = function(_, config)
    -- Auto-detect tsdk from node_modules
    local util = require('vim.lsp.util')
    local root = config.root_dir or vim.fn.getcwd()
    local tsdk = root .. '/node_modules/typescript/lib'
    if vim.fn.isdirectory(tsdk) == 1 then
      config.init_options.typescript.tsdk = tsdk
    end
  end,
}
