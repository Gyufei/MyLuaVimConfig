return {
  'stevearc/conform.nvim',
  cond = not vim.g.vscode,
  dependencies = {
    'mason-org/mason.nvim',
  },
  cmd = 'ConformInfo',
  event = { 'BufWritePre' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = { 'n', 'x' },
      desc = 'Format',
    },
    {
      '<leader>cF',
      function()
        require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })
      end,
      mode = { 'n', 'x' },
      desc = 'Format Injected Langs',
    },
  },
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = 'fallback',
    },
    format_on_save = function(bufnr)
      if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
      end

      return {
        timeout_ms = 3000,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      fish = { 'fish_indent' },
      sh = { 'shfmt' },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
  end,
}
