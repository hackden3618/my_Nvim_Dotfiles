return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		
		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
			},
			win = {
				border = "rounded",
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
			},
		})

		-- Register your leader key groups with descriptions
		wk.add({
			-- Project/File navigation
			{ "<leader>p", group = "Project" },
			-- Find (Telescope)
			{ "<leader>f", group = "Find" },
			-- Code/LSP
			{ "<leader>c", group = "Code" },
			-- Debugging
			{ "<leader>d", group = "Debug" },
            -- Java specific
            { "<leader>j", group = "Java" },
            -- Run code
            { "<leader>r", group = "Run" },
            -- Live server
            { "<leader>l", group = "Live" },
            -- Git
            { "<leader>g", group = "Git" },
            -- Terminal
            { "<leader>t", group = "Terminal" },
            --Windows
            { "<leader>w", group = "Windows" },
            --Tabs
            { "<leader>b", group = "Tabs" },
            --Maven
            { "<leader>m", group = "Maven" },

        })
    end,
}
