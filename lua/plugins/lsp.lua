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

            -- Capabilities for autocompletion
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- LSP keymaps using LspAttach autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, noremap = true, silent = true }

                    -- Navigation
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    -- Code actions
                    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename globally" })   -- opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" }) --opts)
                    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" })       -- opts)

                    -- Diagnostics (NEW!)
                    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
                end,
            })

            -- Configure diagnostic display (NEW!)
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

            -- Customize diagnostic signs in gutter (NEW!)
            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn",  text = "" },
                { name = "DiagnosticSignHint",  text = "" },
                { name = "DiagnosticSignInfo",  text = "" },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            -- Mason LSP setup with handlers
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jdtls",
                    "clangd",
                    "ts_ls",
                    "html",
                    "cssls",
                },
                automatic_installation = true,
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,

                    -- Lua-specific config
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
}
