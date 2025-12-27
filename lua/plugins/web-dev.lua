-- This is the live_server plugin

return {
	-- Terminal helper
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

			-- Create a terminal for live-server
			local Terminal = require("toggleterm.terminal").Terminal
			local live_server = Terminal:new({
				cmd = "live-server",
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
		end,
	},
}
