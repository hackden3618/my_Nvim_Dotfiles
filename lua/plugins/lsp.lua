return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            { "folke/neodev.nvim", opts = {} }, -- Magic for Neovim Lua API
        },

        config = function()
            require("neodev").setup()
            require("mason").setup()

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- -----------------------------------------------------------------
            -- 1. The "Standard" Keymaps
            -- -----------------------------------------------------------------
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    local map = vim.keymap.set

                    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", unpack(opts) })
                    map("n", "gr", require("telescope.builtin").lsp_references, { desc = "References", unpack(opts) })
                    map("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs", unpack(opts) })
                    map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", unpack(opts) })
                    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", unpack(opts) })
                    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", unpack(opts) })
                    map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, { desc = "Format File", unpack(opts) })
                end,
            })

            -- -----------------------------------------------------------------
            -- 2. Modern Diagnostics UI
            -- -----------------------------------------------------------------
            local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.diagnostic.config({
                virtual_text = { prefix = "●", source = "if_many" },
                float = { border = "rounded", source = "always" },
                underline = true,
                severity_sort = true,
                update_in_insert = false,
            })

            -- -----------------------------------------------------------------
            -- 3. Mason Server Handlers (The Heavy Lifting)
            -- -----------------------------------------------------------------
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "intelephense", "emmet_ls", "clangd", 
                    "ts_ls", "html", "cssls", "pyright", "rust_analyzer"
                },
                automatic_installation = true,
                handlers = {
                    -- Default Setup
                    function(server_name)
                        lspconfig[server_name].setup({ capabilities = capabilities })
                    end,

                    -- Python Configuration
                    ["pyright"] = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
                            settings = {
                                python = { analysis = { typeCheckingMode = "basic", autoSearchPaths = true } }
                            }
                        })
                    end,

                    -- Rust Configuration
                    ["rust_analyzer"] = function()
                        lspconfig.rust_analyzer.setup({
                            capabilities = capabilities,
                            settings = {
                                ["rust-analyzer"] = {
                                    checkOnSave = { command = "clippy" },
                                    procMacro = { enabled = true },
                                }
                            }
                        })
                    end,

                    -- C/C++ Configuration
                    ["clangd"] = function()
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" }
                        })
                    end,

                    -- Lua Configuration
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = { Lua = { diagnostics = { globals = { "vim" } } } }
                        })
                    end,

                    -- HTML/PHP Logic
                    ["html"] = function()
                        lspconfig.html.setup({
                            capabilities = capabilities,
                            filetypes = { "html", "php" }
                        })
                    end,
                }
            })
        end,
    },
}
