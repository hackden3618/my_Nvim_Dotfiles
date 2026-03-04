-- =============================================================================
-- CATPPUCCIN.LUA - Colorscheme
-- =============================================================================

return {
    {
        "catppuccin/nvim",
        name     = "catppuccin",
        priority = 1000, -- load before everything else
        opts = {
            flavour = "mocha", -- latte | frappe | macchiato | mocha
            background = {
                light = "latte",
                dark  = "mocha",
            },

            transparent_background = true,
            term_colors            = true,

            styles = {
                comments   = { "italic" },
                conditionals = { "italic" },
                functions  = { "bold" },
                loops      = {},
                keywords   = {},
                strings    = {},
                variables  = {},
                numbers    = {},
                booleans   = {},
                properties = {},
                types      = {},
                operators  = {},
            },

            integrations = {
                treesitter = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors      = { "italic" },
                        hints       = { "italic" },
                        warnings    = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors      = { "underline" },
                        hints       = { "underline" },
                        warnings    = { "underline" },
                        information = { "underline" },
                    },
                },
                barbar    = true,
                gitsigns  = true,
                cmp       = true,
                telescope = true,
                nvimtree  = true,
                which_key = true,
                wilder    = true,
            },
        },

        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
