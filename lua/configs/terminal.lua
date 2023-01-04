local M = {}
function M.config()
	require("toggleterm").setup {
		size = 30,
		open_mapping = [[<c-\>]],
		direction = 'float', -- 'horizontal' 'vertical' 'tab' 'float'
		float_opts = {
			border = 'single',
			width = 140,
			height = 50,
			winblend = 1,
		},
	}
end

return M
