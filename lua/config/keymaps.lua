local map = vim.keymap.set

-- Cursor movement
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Windows and buffers
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })
map('n', '<leader>bD', '<cmd>bdelete!<cr>', { desc = 'Delete Buffer Force' })
map('n', '<leader>bm', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Delete Other Buffers' })
map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Delete Buffers to the Left' })
map('n', '<leader>br', '<cmd>BufferLineCloseRight<cr>', { desc = 'Delete Buffers to the Right' })
map('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = 'Pick Buffer' })

-- Search
map({ 'i', 'n', 's' }, '<esc>', function()
  vim.cmd('nohlsearch')
  return '<esc>'
end, { expr = true, desc = 'Escape and Clear hlsearch' })

map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Editing
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

map({ 'i', 'x', 'n', 's' }, '<D-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

local function run_current_file()
  vim.cmd('write')

  local file = vim.api.nvim_buf_get_name(0)
  local filetype = vim.bo.filetype
  local commands = {
    javascript = { 'node', file },
    lua = { 'lua', file },
    python = { 'python3', file },
    sh = { 'sh', file },
  }
  local command = commands[filetype]
  local cwd

  if filetype == 'rust' then
    local manifest = vim.fs.find('Cargo.toml', { path = vim.fs.dirname(file), upward = true })[1]
    if not manifest then
      vim.notify('Cargo.toml not found', vim.log.levels.ERROR)
      return
    end
    command = { 'cargo', 'run' }
    cwd = vim.fs.dirname(manifest)
  end

  if not command then
    vim.notify('No runner configured for filetype: ' .. filetype, vim.log.levels.WARN)
    return
  end
  if vim.fn.executable(command[1]) == 0 then
    vim.notify('Executable not found: ' .. command[1], vim.log.levels.ERROR)
    return
  end

  vim.cmd('botright 15split')
  vim.fn.termopen(command, { cwd = cwd })
  vim.cmd('startinsert')
end

map('n', '<leader>r', run_current_file, { desc = 'Run Current File' })
map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit Window' })

map('x', '<', '<gv')
map('x', '>', '>gv')

map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })

map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
