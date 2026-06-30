return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    cond = not vim.g.vscode,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<S-h>',      '<cmd>BufferLineCyclePrev<cr>',   desc = 'Previous Buffer' },
        { '<S-l>',      '<cmd>BufferLineCycleNext<cr>',   desc = 'Next Buffer' },
        { '<leader>bp', '<cmd>BufferLineTogglePin<cr>',   desc = 'Toggle Buffer Pin' },
        { '<leader>bm', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Other Buffers' },
    },
    opts = {
        options = {
            mode = 'buffers',
            diagnostics = 'nvim_lsp',
            always_show_bufferline = false,
            separator_style = 'thin',
            offsets = {
                {
                    filetype = 'neo-tree',
                    text = 'Explorer',
                    text_align = 'center',
                    separator = true,
                },
            },
        },
    },
}
