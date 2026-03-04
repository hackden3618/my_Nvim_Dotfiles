-- =============================================================================
-- NVIM-TREE.LUA - File explorer sidebar
-- =============================================================================

return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                },
            })

            -- Toggle file tree with Ctrl+n
            vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        end,
    },
}
