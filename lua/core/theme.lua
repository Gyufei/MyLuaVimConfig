vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "NotoMono Nerd Font Mono"

vim.g.edge_style = 'aura' -- neon, aura
vim.g.edge_better_performance = 1
vim.cmd("colorscheme edge")
vim.cmd("set background=dark")

local function set_bg_light()
	vim.cmd('set background=light')
	local colors_name = vim.g.colors_name
	vim.cmd('colorscheme shine')
	vim.cmd('colorscheme ' .. colors_name)
end

local function set_bg_dark()
	vim.cmd('set background=dark')
	local colors_name = vim.g.colors_name
	vim.cmd('colorscheme ron')
	vim.cmd('colorscheme ' .. colors_name)
end

-- vim.keymap.set('n', '<leader>vl', set_bg_light)
-- vim.keymap.set('n', '<leader>vd', set_bg_dark)
