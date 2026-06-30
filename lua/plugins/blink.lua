return {
  'saghen/blink.cmp',
  version = '*',
  cond = not vim.g.vscode,
  event = { 'InsertEnter', 'CmdlineEnter' },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = false,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
      transform_items = function(_, items)
        local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
        return vim.tbl_filter(function(item)
          return item.kind ~= CompletionItemKind.Snippet
        end, items)
      end,
    },
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<Right>'] = false,
        ['<Left>'] = false,
      },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ':'
          end,
        },
        ghost_text = {
          enabled = true,
        },
      },
    },
    keymap = {
      preset = 'enter',
      ['<C-y>'] = { 'select_and_accept' },
    },
  },
  config = function(_, opts)
    require('blink.cmp').setup(opts)
  end,
}
