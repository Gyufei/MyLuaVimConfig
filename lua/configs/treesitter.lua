local M = {}
function M.config()
	require 'nvim-treesitter.configs'.setup {
		ensure_installed = {
            "html",
            "javascript",
            "typescript",
            "json",
            "lua",
            "tsx",
            "css",
            "yaml"
        },
		sync_install = true,
		ignore_install = {},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}
end

return M
