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
    {
      '<leader>ge',
      function()
        require('neo-tree.command').execute({ source = 'git_status', toggle = true })
      end,
      desc = 'Git Explorer',
    },
    {
      '<leader>be',
      function()
        require('neo-tree.command').execute({ source = 'buffers', toggle = true })
      end,
      desc = 'Buffer Explorer',
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
    sources = { 'filesystem', 'buffers', 'git_status' },
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
            vim.fn.setreg('+', node:get_id(), 'c')
          end,
          desc = 'Copy Path to Clipboard',
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
      git_status = {
        symbols = {
          unstaged = 'M',
          staged = 'S',
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)

    vim.api.nvim_create_autocmd('TermClose', {
      pattern = '*lazygit',
      callback = function()
        if package.loaded['neo-tree.sources.git_status'] then
          require('neo-tree.sources.git_status').refresh()
        end
      end,
    })
  end,
}
