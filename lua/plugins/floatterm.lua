-- Native floating terminal replacement for toggleterm
local float_scale = 0.85
local terms = {}

local function create_float(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * float_scale)
  local height = opts.height or math.floor(vim.o.lines * float_scale)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = opts.buf
  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  })

  return buf, win
end

local function toggle_term(key, cmd)
  local state = terms[key] or {}

  -- If window is open, close it
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
    terms[key] = state
    return
  end

  -- Open float with existing or new buffer
  local buf, win = create_float({ buf = state.buf })
  state.win = win

  -- If no terminal job in this buffer, start one
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    vim.fn.termopen(cmd or vim.o.shell)
    state.buf = buf
  end

  vim.cmd('startinsert!')
  terms[key] = state
end

local function toggle_vertical(key, cmd)
  local state = terms[key] or {}

  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
    terms[key] = state
    return
  end

  vim.cmd('vsplit')
  local win = vim.api.nvim_get_current_win()
  vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.4))

  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    vim.api.nvim_win_set_buf(win, state.buf)
  else
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(win, buf)
    vim.fn.termopen(cmd or vim.o.shell)
    state.buf = buf
  end

  state.win = win
  vim.cmd('startinsert!')
  terms[key] = state
end

vim.keymap.set({ 'n', 't' }, '<C-\\>', function() toggle_term('default') end, { desc = 'Toggle terminal' })
vim.keymap.set('n', '<leader>lg', function()
  vim.cmd('silent! wa')
  toggle_term('lazygit', 'lazygit')
end, { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>ll', function() toggle_term('lazyglab', 'lazyglab') end, { desc = 'LazyGlab' })
vim.keymap.set('n', '<leader>ac', function() toggle_vertical('claude', 'claude') end, { desc = 'Toggle Claude Code' })

return {}
