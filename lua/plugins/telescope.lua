return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    path_display = { "truncate" },
                    mappings = {
                        i = {
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                        },
                    },
                },
            })
            -- Load fzf if it was compiled successfully
            pcall(telescope.load_extension, "fzf")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            -- get access to telescopes navigation functions
            local actions = require("telescope.actions")

            require("telescope").setup({
                -- use ui-select dropdown as our ui
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                },
                -- set keymappings to navigate through items in the telescope io
                mappings = {
                    i = {
                        -- use <cltr> + n to go to the next option
                        ["<C-n>"] = actions.cycle_history_next,
                        -- use <cltr> + p to go to the previous option
                        ["<C-p>"] = actions.cycle_history_prev,
                        -- use <cltr> + j to go to the next preview
                        ["<C-j>"] = actions.move_selection_next,
                        -- use <cltr> + k to go to the previous preview
                        ["<C-k>"] = actions.move_selection_previous,
                    }
                },
                -- load the ui-select extension
                require("telescope").load_extension("ui-select")
            })
        end
    }
}
