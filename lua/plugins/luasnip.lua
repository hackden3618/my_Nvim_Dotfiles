-- =============================================================================
-- LUASNIP.LUA - Snippet engine with VSCode-style snippet support
-- =============================================================================

return {
    {
        "L3MON4D3/LuaSnip",
        version = "*",
        build   = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets", -- community snippet library
        },

        config = function()
            local luasnip = require("luasnip")

            -- Load VSCode-format snippets (from friendly-snippets)
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Extend JSX/TSX with HTML snippets
            luasnip.filetype_extend("javascriptreact", { "html" })
            luasnip.filetype_extend("typescriptreact", { "html" })

            -- Extend PHP with HTML snippets so html:5, div, etc. work in PHP files
            luasnip.filetype_extend("php", { "html" })
        end,
    },
}
