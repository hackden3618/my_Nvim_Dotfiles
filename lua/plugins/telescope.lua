-- plugins/telescope.lua:
return {
	'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files"},
		{"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep(text in files)"},
	},
}
