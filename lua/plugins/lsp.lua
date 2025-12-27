return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Setup Mason first
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",      -- Lua
					"jdtls",       -- Java
					"clangd",      -- C/C++
					"ts_ls",       -- TypeScript/JavaScript
					"html",        -- HTML
					"cssls",       -- CSS
				},
				automatic_installation = true,
			})

			-- Capabilities for autocompletion
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP keymaps (set when LSP attaches)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local opts = { buffer = bufnr, noremap = true, silent = true }
					
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
				end,
			})

			-- Server configurations using new API
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				clangd = {},
				jdtls = {},
				ts_ls = {},
				html = {},
				cssls = {},
			}

			-- Setup each server
			for server, config in pairs(servers) do
				config.capabilities = capabilities
				require("lspconfig")[server].setup(config)
			end
		end,
	},
}
