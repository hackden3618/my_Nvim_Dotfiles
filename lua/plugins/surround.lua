-- =============================================================================
-- SURROUND.LUA - Add/change/delete surrounding characters
-- Keymaps: ys (add), cs (change), ds (delete), S (visual)
-- =============================================================================

return {
    {
        "kylechui/nvim-surround",
        version = "*",
        event   = "VeryLazy",

        config = function()
            require("nvim-surround").setup()
        end,
    },
}
