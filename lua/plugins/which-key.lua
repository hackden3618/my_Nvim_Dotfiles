return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.setup({
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
            },
            window = {
                border = "rounded",
                position = "bottom",
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
            },
        })


        -- Register your leader key groups with descriptions
        wk.add({
            --show files
            { "C-n",        desc = "File tree (GUI)" },
            { "<leader>pv", desc = "File tree" },
            { "<leader>f",  group = "Telescope File search" },
            { "<leader>ff", desc = "find files" },
            { "<leader>fg", desc = "live grep" },
        })
    end,
}
