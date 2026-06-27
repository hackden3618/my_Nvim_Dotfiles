return {
	{
		-- Main LSP configuration plugin
		"neovim/nvim-lspconfig",

		dependencies = {
			-- Installs LSP servers automatically
			"williamboman/mason.nvim",

			-- Bridges mason + lspconfig
			"williamboman/mason-lspconfig.nvim",

			-- Adds completion capabilities to LSP
			"hrsh7th/cmp-nvim-lsp",
		},

		config = function()
			-----------------------------------------------------------
			-- MASON SETUP
			-----------------------------------------------------------

			-- Starts Mason package manager
			require("mason").setup()

			-----------------------------------------------------------
			-- COMPLETION CAPABILITIES
			-----------------------------------------------------------

			-- Makes LSP aware of nvim-cmp completions
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-----------------------------------------------------------
			-- LSP KEYMAPS
			-----------------------------------------------------------

			-- Runs whenever an LSP attaches to a buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),

				callback = function(ev)
					-- Common keymap options
					local opts = {
						buffer = ev.buf,
						noremap = true,
						silent = true,
					}

					---------------------------------------------------
					-- NAVIGATION
					---------------------------------------------------

					-- Go to definition
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

					-- Go to declaration
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

					-- Show implementations
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

					-- Show references
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					-- Hover documentation
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					---------------------------------------------------
					-- CODE ACTIONS
					---------------------------------------------------

					-- Rename symbol everywhere
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
						buffer = ev.buf,
						desc = "Rename Symbol",
					})

					-- Quick fixes / actions
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
						buffer = ev.buf,
						desc = "Code Actions",
					})

					-- Format file
					vim.keymap.set("n", "<leader>cf", function()
						vim.lsp.buf.format({ async = true })
					end, {
						buffer = ev.buf,
						desc = "Format Code",
					})

					---------------------------------------------------
					-- DIAGNOSTICS
					---------------------------------------------------

					-- Floating diagnostic window
					vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

					-- Previous diagnostic
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

					-- Next diagnostic
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

					-- Populate location list
					vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
				end,
			})

			-----------------------------------------------------------
			-- DIAGNOSTIC UI CONFIG
			-----------------------------------------------------------

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					source = "if_many",
				},

				float = {
					source = "always",
					border = "rounded",
					header = "",
					prefix = "",
				},

				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-----------------------------------------------------------
			-- GUTTER ICONS
			-----------------------------------------------------------

			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, {
					texthl = sign.name,
					text = sign.text,
					numhl = "",
				})
			end

			-----------------------------------------------------------
			-- LSP SERVER INSTALLATION
			-----------------------------------------------------------

			require("mason-lspconfig").setup({
				ensure_installed = {
					---------------------------------------------------
					-- SYSTEM / GENERAL
					---------------------------------------------------
					"lua_ls",
					"clangd",
					"jdtls",

					---------------------------------------------------
					-- WEB DEVELOPMENT
					---------------------------------------------------
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",

					---------------------------------------------------
					-- OPTIONAL
					---------------------------------------------------
					"jsonls",
					"emmet_ls",
				},

				automatic_installation = true,

				-------------------------------------------------------
				-- SERVER HANDLERS
				-------------------------------------------------------

				handlers = {
					---------------------------------------------------
					-- DEFAULT HANDLER
					---------------------------------------------------

					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					---------------------------------------------------
					-- LUA LANGUAGE SERVER
					---------------------------------------------------

					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,

							settings = {
								Lua = {
									diagnostics = {
										-- Prevents "undefined global vim"
										globals = { "vim" },
									},

									workspace = {
										checkThirdParty = false,
									},
								},
							},
						})
					end,

					---------------------------------------------------
					-- TAILWINDCSS
					---------------------------------------------------

					["tailwindcss"] = function()
						require("lspconfig").tailwindcss.setup({
							capabilities = capabilities,

							filetypes = {
								"html",
								"css",
								"scss",
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
								"tsx",
								"jsx",
							},
						})
					end,

					---------------------------------------------------
					-- EMMET
					---------------------------------------------------

					["emmet_ls"] = function()
						require("lspconfig").emmet_ls.setup({
							capabilities = capabilities,

							filetypes = {
								"html",
								"css",
								"scss",
								"javascriptreact",
								"typescriptreact",
								"tsx",
								"jsx",
							},
						})
					end,
				},
			})
		end,
	},
}
