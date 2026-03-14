return {
	{
		"nvim-treesitter/nvim-treesitter",
		ft = { "java", "xml" },
		config = function()
			-- Maven commands
			vim.keymap.set("n", "<leader>mc", function()
				vim.cmd("split | term mvn clean compile")
			end, { desc = "Maven: Compile" })

			vim.keymap.set("n", "<leader>mr", function()
				vim.cmd("split | term mvn exec:java")
			end, { desc = "Maven: Run" })

			vim.keymap.set("n", "<leader>mt", function()
				vim.cmd("split | term mvn test")
			end, { desc = "Maven: Test" })

			vim.keymap.set("n", "<leader>mp", function()
				vim.cmd("split | term mvn package")
			end, { desc = "Maven: Package" })

			vim.keymap.set("n", "<leader>mC", function()
				vim.cmd("split | term mvn clean")
			end, { desc = "Maven: Clean" })

			vim.keymap.set("n", "<leader>mi", function()
				vim.cmd("split | term mvn clean install")
			end, { desc = "Maven: Install" })
		end,
	},
}
