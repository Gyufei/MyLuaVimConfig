local parsers = {
  'bash',
  'c',
  'css',
  'diff',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'ron',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'xml',
  'yaml',
}

local installed_parsers

local function refresh_installed_parsers()
  local ok, ts = pcall(require, 'nvim-treesitter')
  if ok and ts.get_installed then
    installed_parsers = ts.get_installed()
  else
    installed_parsers = {}
  end
end

local function parser_installed(lang)
  if not installed_parsers then
    refresh_installed_parsers()
  end

  return vim.tbl_contains(installed_parsers, lang)
end

local function has_query(lang, query)
  local ok, result = pcall(vim.treesitter.query.get, lang, query)
  return ok and result ~= nil
end

local function setup_buffer(bufnr, opts)
  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  if not lang or not parser_installed(lang) or not has_query(lang, 'highlights') then
    return
  end

  if vim.tbl_get(opts, 'highlight', 'enable') ~= false then
    pcall(vim.treesitter.start, bufnr, lang)
  end

  if vim.tbl_get(opts, 'folds', 'enable') ~= false and has_query(lang, 'folds') then
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    commit = vim.fn.has('nvim-0.12') == 0 and '7caec274fd19c12b55902a5b795100d21531391f' or nil,
    version = false,
    event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    opts = {
      highlight = { enable = true },
      folds = { enable = true },
      ensure_installed = parsers,
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)
      refresh_installed_parsers()

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_treesitter', { clear = true }),
        callback = function(ev)
          setup_buffer(ev.buf, opts)
        end,
      })

      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
          setup_buffer(bufnr, opts)
        end
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      move = {
        enable = true,
        set_jumps = true,
        keys = {
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
        },
      },
    },
    config = function(_, opts)
      local ok, textobjects = pcall(require, 'nvim-treesitter-textobjects')
      if not ok or not textobjects.setup then
        return
      end

      textobjects.setup(opts)

      local function attach(bufnr)
        if not vim.tbl_get(opts, 'move', 'enable') then
          return
        end

        local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
        if not lang or not parser_installed(lang) or not has_query(lang, 'textobjects') then
          return
        end

        for method, keymaps in pairs(vim.tbl_get(opts, 'move', 'keys') or {}) do
          for key, query in pairs(keymaps) do
            vim.keymap.set({ 'n', 'x', 'o' }, key, function()
              if vim.wo.diff and key:find('[cC]') then
                return vim.cmd('normal! ' .. key)
              end
              require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
            end, {
              buffer = bufnr,
              silent = true,
              desc = 'Treesitter textobject move',
            })
          end
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_treesitter_textobjects', { clear = true }),
        callback = function(ev)
          attach(ev.buf)
        end,
      })

      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
          attach(bufnr)
        end
      end
    end,
  },
}
