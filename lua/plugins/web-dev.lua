-- This is the live_server plugin

return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				direction = "horizontal",
				close_on_exit = true,
			})

			-- Live server function that uses current file's directory
			function _LIVE_SERVER_TOGGLE()
				local file_dir = vim.fn.expand("%:p:h")  -- Get directory of current file
				local cmd = "live-server " .. vim.fn.shellescape(file_dir)
				
				vim.cmd("split")
				vim.cmd("term " .. cmd)
			end

			vim.keymap.set("n", "<leader>ls", "<cmd>lua _LIVE_SERVER_TOGGLE()<CR>", { desc = "Toggle Live Server" })

			-- Quick run commands for different languages
			vim.keymap.set("n", "<leader>rj", ":split | term javac % && java %:r<CR>", { desc = "Run Java" })
			vim.keymap.set("n", "<leader>rc", ":split | term gcc % -o %:r && ./%:r<CR>", { desc = "Run C" })
			vim.keymap.set("n", "<leader>rp", ":split | term python %<CR>", { desc = "Run Python" })
		end,
	},
}
