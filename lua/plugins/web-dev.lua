-- =============================================================================
-- WEB-DEV.LUA - Live server, HTML/CSS completions, quick run keymaps
-- =============================================================================

return {
    -- Terminal + live server toggle
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config  = function()
            require("toggleterm").setup({
                size         = 20,
                open_mapping = [[<C-\>]],
                direction    = "horizontal",
                close_on_exit = true,
            })

            -- Live server: serves the directory of the currently open file
            function _LIVE_SERVER_TOGGLE()
                local file_dir = vim.fn.expand("%:p:h")
                vim.cmd("split")
                vim.cmd("term live-server " .. vim.fn.shellescape(file_dir))
            end

            vim.keymap.set("n", "<leader>ls", "<cmd>lua _LIVE_SERVER_TOGGLE()<CR>", { desc = "Toggle Live Server" })

            -- Quick run: C
            vim.keymap.set("n", "<leader>rc",  ":split | term gcc % -o %:r && ./%:r<CR>", { desc = "Run C" })

            -- Quick run: Python
            vim.keymap.set("n", "<leader>rp",  ":split | term python %<CR>",              { desc = "Run Python" })

            -- Quick run: PHP (uses XAMPP's PHP binary)
            vim.keymap.set("n", "<leader>rph", function()
                local file = vim.fn.expand("%:p")
                vim.cmd("split")
                vim.cmd("resize 15")
                vim.cmd("term /opt/lampp/bin/php " .. vim.fn.shellescape(file))
                vim.cmd("startinsert")
            end, { desc = "Run PHP" })
        end,
    },

    -- HTML/CSS class completions inside html, php, jsx, etc.
    {
        "Jezda1337/nvim-html-css",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            enable_on = { "html", "jsx", "tsx", "astro", "vue", "svelte", "php" },
        },
    },
}
