local M = {}

function M.config()
    local cmp = require 'cmp'
    local luasnip = require("luasnip")
    -- load snippets from path/of/your/nvim/config/my-cool-snippets
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

    local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
          }
    end

    local cmp_window = require "cmp.utils.window"
    cmp_window.info_ = cmp_window.info
    cmp_window.info = function(self)
        local info = self:info_()
        info.scrollable = false
        return info
    end

    cmp.setup({
        window = {
            completion = {
                border = border "CmpBorder",
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            },
            documentation = {
                border = border "CmpDocBorder",
            },
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            })
        },
        sources = {
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
        }
    })

    local devicons = require('nvim-web-devicons')
    cmp.register_source('devicons', {
        complete = function(_, _, callback)
        local items = {}
        for _, icon in pairs(devicons.get_icons()) do
            table.insert(items, {
            label = icon.icon .. '  ' .. icon.name,
            insertText = icon.icon,
            filterText = icon.name,
            })
        end
        callback({ items = items })
        end,
    })

    local saga = require 'lspsaga'
    saga.init_lsp_saga({})
end

return M
