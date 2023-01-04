local M = {}

function M.config()
	require('bufferline').setup {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
				local s = " "
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and " "
						or (e == "warning" and " " or "")
					s = s .. sym
				end
				return s
			end,

			offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
			separator_style = "thin",
			sort_by = 'id'
		}
	}
end

return M
