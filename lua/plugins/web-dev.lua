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

			local Terminal = require("toggleterm.terminal").Terminal

			-- Live server terminal that opens in project directory
			local live_server = Terminal:new({
				cmd = "live-server " .. vim.fn.getcwd(),
				hidden = true,
				direction = "float",
				on_open = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _LIVE_SERVER_TOGGLE()
				live_server:toggle()
			end

			vim.keymap.set("n", "<leader>ls", "<cmd>lua _LIVE_SERVER_TOGGLE()<CR>", { desc = "Toggle Live Server" })

			-- Quick run commands for different languages
			vim.keymap.set("n", "<leader>rj", ":split | term javac % && java %:r<CR>", { desc = "Run Java" })
			vim.keymap.set("n", "<leader>rc", ":split | term gcc % -o %:r && ./%:r<CR>", { desc = "Run C" })
			vim.keymap.set("n", "<leader>rp", ":split | term python %<CR>", { desc = "Run Python" })
		end,
	},
}
