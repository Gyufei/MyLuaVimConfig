local function root_dir()
  return vim.fs.root(0, { '.git' }) or vim.uv.cwd()
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  cond = not vim.g.vscode,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = root_dir() })
      end,
      desc = 'Explorer NeoTree (Root Dir)',
    },
    {
      '<leader>E',
      function()
        require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = 'Explorer NeoTree (cwd)',
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
      desc = 'Start Neo-tree with directory',
      once = true,
      callback = function()
        if package.loaded['neo-tree'] then
          return
        end

        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == 'directory' then
          require('neo-tree')
        end
      end,
    })
  end,
  opts = {
    sources = { 'filesystem' },
    enable_git_status = false,
    open_files_do_not_replace_types = { 'terminal', 'qf' },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            if not node or not node.id then
              vim.notify('No node selected.', vim.log.levels.WARN)
              return
            end

            if vim.fn.has('clipboard') == 0 then
              vim.notify('System clipboard is not available.', vim.log.levels.ERROR)
              return
            end

            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify
            local choices = {
              { label = 'Absolute path', value = filepath },
              { label = 'Path relative to CWD', value = modify(filepath, ':.') },
              { label = 'Path relative to HOME', value = modify(filepath, ':~') },
              { label = 'Filename', value = filename },
              { label = 'Filename without extension', value = modify(filename, ':r') },
              { label = 'Extension of the filename', value = modify(filename, ':e') },
            }

            require('snacks').picker.select(choices, {
              prompt = 'Choose to copy to clipboard:',
              format_item = function(item)
                return string.format('%-30s %s', item.label, item.value)
              end,
            }, function(choice)
              if not choice then
                vim.notify('Copy cancelled.', vim.log.levels.INFO)
                return
              end

              vim.fn.setreg('+', choice.value)
              vim.notify('Copied to clipboard: ' .. choice.value)
            end)
          end,
          desc = 'Choose Path to Copy to Clipboard',
        },
        ['O'] = {
          function(state)
            vim.ui.open(state.tree:get_node().path)
          end,
          desc = 'Open with System Application',
        },
        ['P'] = { 'toggle_preview', config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = '>',
        expander_expanded = 'v',
        expander_highlight = 'NeoTreeExpander',
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
  end,
}
