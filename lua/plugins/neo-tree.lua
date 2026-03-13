return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle file explorer', silent = true },
    { '<leader>r', '<cmd>Neotree reveal<CR>', desc = 'Locate file in explorer', silent = true },
  },
  opts = {
    window = {
      width = 50,
      mappings = {
        ['h'] = function(state)
          local node = state.tree:get_node()
          local renderer = require('neo-tree.ui.renderer')
          if node:has_children() and node:is_expanded() then
            require('neo-tree.sources.filesystem').toggle_directory(state, node)
          else
            -- Scan lines above cursor for nearest expanded directory
            local cur_line = vim.api.nvim_win_get_cursor(0)[1]
            local found = nil
            for line = cur_line - 1, 1, -1 do
              local above = state.tree:get_node(line)
              if above and above:has_children() and above:is_expanded() then
                found = above
                break
              end
            end
            if found then
              renderer.focus_node(state, found:get_id())
            else
              renderer.focus_node(state, node:get_parent_id())
            end
          end
        end,
        ['l'] = 'open',
        ['o'] = 'open',
        ['O'] = 'order_by_type',
        ['<space>'] = 'noop',
      },
    },
  },
}
