return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua", "vim", "vimdoc", "query",
			"rust", "c", "cpp", "java",
			"python", "html", "css", "javascript",
			"typescript", "json", "markdown"
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
}
