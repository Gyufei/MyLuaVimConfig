local M = {}
function M.config()
	-- lualine config
	require('lualine').setup {
    options = {
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
		},
    }
end

return M
