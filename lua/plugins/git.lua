-- =============================================================================
-- GIT.LUA - Git integration (gitsigns + fugitive)
-- =============================================================================

return {
    -- Gutter signs and hunk previews
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({})

            vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it Preview [H]unk" })
        end,
    },

    -- Full git commands from inside nvim
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gb", ":Git blame<CR>",    { desc = "[G]it [B]lame" })
            vim.keymap.set("n", "<leader>gA", ":Git add .<CR>",    { desc = "[G]it Add [A]ll" })
            vim.keymap.set("n", "<leader>ga", ":Git add ",         { desc = "[G]it [A]dd File" })
            vim.keymap.set("n", "<leader>gc", ":Git commit -m ",   { desc = "[G]it [C]ommit" })
            vim.keymap.set("n", "<leader>gP", ":Git push",         { desc = "[G]it [P]ush" })
        end,
    },
}
