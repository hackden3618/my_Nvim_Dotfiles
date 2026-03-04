-- =============================================================================
-- HARPOON.LUA - Quick file bookmarking and navigation
-- =============================================================================

return {
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            -- Mark current file
            vim.keymap.set("n", "<S-m>", "<cmd>lua require('harpoon.mark').add_file()<CR>",      { desc = "Harpoon Mark File" })
            -- Open harpoon quick menu
            vim.keymap.set("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Harpoon Menu" })
        end,
    },
}
