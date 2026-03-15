return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      opts = {
        hint = 'floating-big-letter',
        filter_rules = {
          bo = { filetype = { 'NvimTree', 'notify' }, buftype = { 'terminal', 'quickfix' } },
        },
      },
    },
  },
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer', silent = true },
    { '<leader>r', '<cmd>NvimTreeFindFile<CR>', desc = 'Locate file in explorer', silent = true },
  },
  opts = {
    view = {
      width = 50,
    },
    renderer = {
      group_empty = true,
    },
    git = {
      enable = true,
      timeout = 400,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      local map = function(key, fn, desc)
        vim.keymap.set('n', key, fn, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- h: collapse current dir, or jump to nearest expanded parent above
      map('h', function()
        local node = api.tree.get_node_under_cursor()
        if node.nodes and node.open then
          api.node.open.edit()
        else
          local core = require('nvim-tree.core')
          local explorer = core.get_explorer()
          if not explorer then return end
          local cur_line = vim.api.nvim_win_get_cursor(0)[1]
          local nodes_by_line = explorer:get_nodes_by_line(core.get_nodes_starting_line())
          for line = cur_line - 1, 1, -1 do
            local above = nodes_by_line[line]
            if above and above.nodes and above.open then
              vim.api.nvim_win_set_cursor(0, { line, 0 })
              return
            end
          end
          api.node.navigate.parent_close()
        end
      end, 'Collapse or go to parent')

      -- l: open with window picker
      map('l', function()
        local node = api.tree.get_node_under_cursor()
        if node.nodes then
          api.node.open.edit()
        else
          local picker = require('window-picker')
          local win = picker.pick_window()
          if win then
            vim.api.nvim_set_current_win(win)
            vim.cmd('edit ' .. vim.fn.fnameescape(node.absolute_path))
          end
        end
      end, 'Open with window picker')

      -- Unbind space (leader conflict)
      pcall(vim.keymap.del, 'n', '<Space>', { buffer = bufnr })
    end,
  },
}
