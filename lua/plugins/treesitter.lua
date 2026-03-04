-- =============================================================================
-- TREESITTER.LUA - Syntax highlighting and indentation
-- =============================================================================

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts  = {
            ensure_installed = {
                "lua", "vim", "vimdoc", "query",
                "c", "cpp", "java",
                "python",
                "php",      -- PHP syntax
                "phpdoc",   -- PHP docblock syntax (needed for HTML injection in PHP)
                "html", "css",
                "javascript", "typescript",
                "json", "markdown",
            },
            highlight = { enable = true },
            indent    = { enable = true },
        },
    },
}
