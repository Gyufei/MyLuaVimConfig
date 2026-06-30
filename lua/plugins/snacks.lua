local function root_dir()
	return vim.fs.root(0, { ".git" }) or vim.uv.cwd()
end

local function pick(source, opts)
	opts = opts or {}
	return function()
		local picker_opts = vim.deepcopy(opts)
		if picker_opts.root ~= false then
			picker_opts.cwd = picker_opts.cwd or root_dir()
		end
		picker_opts.root = nil
		Snacks.picker.pick(source, picker_opts)
	end
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	cond = not vim.g.vscode,
	opts = {
		picker = {
			win = {
				input = {
					keys = {
						["<a-c>"] = {
							"toggle_cwd",
							mode = { "n", "i" },
						},
					},
				},
			},
			actions = {
				toggle_cwd = function(picker)
					local root = root_dir()
					local cwd = vim.fs.normalize(vim.uv.cwd() or ".")
					local current = picker:cwd()
					picker:set_cwd(current == root and cwd or root)
					picker:find()
				end,
			},
		},
	},
	keys = {
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>sg",
			pick("grep"),
			desc = "Grep (Root Dir)",
		},
		{
			"<leader>sG",
			pick("grep", { root = false }),
			desc = "Grep (cwd)",
		},
		{
			"<leader><space>",
			pick("files"),
			desc = "Find Files (Root Dir)",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fB",
			function()
				Snacks.picker.buffers({ hidden = true, nofile = true })
			end,
			desc = "Buffers (all)",
		},
		{
			"<leader>ff",
			pick("files"),
			desc = "Find Files (Root Dir)",
		},
		{
			"<leader>fF",
			pick("files", { root = false }),
			desc = "Find Files (cwd)",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Files (git-files)",
		},
		{ "<leader>fr", pick("recent"), desc = "Recent" },
		{
			"<leader>fR",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Recent (cwd)",
		},
		{
			"<leader>sw",
			pick("grep_word"),
			mode = { "n", "x" },
			desc = "Visual selection or word (Root Dir)",
		},
		{
			"<leader>/",
			pick("grep_word"),
			mode = { "n", "x" },
			desc = "Visual selection or word (Root Dir)",
		},
		{
			"<leader>sW",
			pick("grep_word", { root = false }),
			mode = { "n", "x" },
			desc = "Visual selection or word (cwd)",
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
	end,
}
