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
			{ "<leader>pv", desc = "File explorer" },
			
			-- Find (Telescope)
			{ "<leader>f", group = "Find" },
			{ "<leader>ff", desc = "Find files" },
			{ "<leader>fg", desc = "Live grep" },
			
			-- Code/LSP
			{ "<leader>c", group = "Code" },
			{ "<leader>ca", desc = "Code actions" },
			{ "<leader>cr", desc = "Rename symbol" },
			
			-- Debugging
			{ "<leader>d", group = "Debug" },
			{ "<leader>db", desc = "Toggle breakpoint" },
			{ "<leader>dc", desc = "Continue/Start" },
			{ "<leader>di", desc = "Step into" },
			{ "<leader>do", desc = "Step over" },
            { "<leader>dO", desc = "Step out" },
            { "<leader>dt", desc = "Terminate" },
            { "<leader>du", desc = "Toggle UI" },

            -- Java specific
            { "<leader>j", group = "Java" },
            { "<leader>jo", desc = "Organize imports" },
            { "<leader>jv", desc = "Extract variable" },
            { "<leader>jc", desc = "Compile all Java files" },
            { "<leader>jcd", desc = "Compile with JDBC" },
            { "<leader>jm", desc = "Extract method" },
            -- Run code
            { "<leader>r", group = "Run" },
            { "<leader>rj", desc = "Run Java" },
            { "<leader>rjd", desc = "Run Java (JDBC)" },
            { "<leader>rc", desc = "Run C" },
            { "<leader>rp", desc = "Run Python" },

            -- Live server
            { "<leader>l", group = "Live" },
            { "<leader>ls", desc = "Live server" },

            -- Git
            { "<leader>g", group = "Git" },

            -- Terminal
            { "<leader>t", group = "Terminal" },


        })
    end,
}
