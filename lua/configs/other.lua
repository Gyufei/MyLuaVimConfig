local M = {}
function M.config()
    require('gitsigns').setup {}

    require("github-theme").setup({
        theme_style = "dark",
    })

    require("nvim-autopairs").setup({
        disable_in_macro = true,
        disable_in_visualblock = true,
        enable_check_bracket_line = false,
        map_c_h = true,
        map_c_w = true,
        fast_wrap = {
            map = '<C-s>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'Search',
            highlight_grey='Comment'
        }
    })

    require('Comment').setup()
end

return M
