-- =============================================================================
-- MISC.LUA - Small utility plugins
-- =============================================================================

return {
    -- Auto-close brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event  = "InsertEnter",
        config = true,
    },
}
