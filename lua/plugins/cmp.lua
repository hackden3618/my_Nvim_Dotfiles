-- =============================================================================
-- CMP.LUA - Autocompletion engine
-- =============================================================================

return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",    -- LSP completions
            "hrsh7th/cmp-buffer",      -- buffer word completions
            "hrsh7th/cmp-path",        -- file path completions
            "L3MON4D3/LuaSnip",        -- snippet engine
            "saadparwaiz1/cmp_luasnip" -- snippet completions
        },

        config = function()
            local cmp     = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP (intelephense, ts_ls, etc.)
                    { name = "luasnip"  }, -- snippets
                    { name = "buffer"   }, -- words in open buffers
                    { name = "path"     }, -- file paths
                }),
            })
        end,
    },
}
