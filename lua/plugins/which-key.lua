-- =============================================================================
-- WHICH-KEY.LUA - Keymap hint popup
-- =============================================================================

return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        config = function()
            local wk = require("which-key")

            wk.setup({
                plugins = {
                    marks      = true,
                    registers  = true,
                    spelling   = { enabled = true, suggestions = 20 },
                },
                win    = { border = "rounded" },
                layout = {
                    height  = { min = 4,  max = 25 },
                    width   = { min = 20, max = 50 },
                    spacing = 3,
                },
            })

            wk.add({
                -- Find (Telescope)
                { "<leader>f",   group = "Find" },

                -- Code / LSP
                { "<leader>c",   group = "Code" },
                { "<leader>cr",  desc  = "Rename Globally" },
                { "<leader>ca",  desc  = "Code Actions" },
                { "<leader>cf",  desc  = "Format File" },

                -- Debugging
                { "<leader>d",   group = "Debug" },
                { "<leader>db",  desc  = "Toggle Breakpoint" },
                { "<leader>dc",  desc  = "Continue" },
                { "<leader>di",  desc  = "Step Into" },
                { "<leader>do",  desc  = "Step Over" },
                { "<leader>dO",  desc  = "Step Out" },
                { "<leader>dt",  desc  = "Terminate" },
                { "<leader>du",  desc  = "Toggle DAP UI" },

                -- Java
                { "<leader>j",   group = "Java" },
                { "<leader>jo",  desc  = "Organize Imports" },
                { "<leader>jv",  desc  = "Extract Variable" },
                { "<leader>jc",  desc  = "Extract Constant" },
                { "<leader>jm",  desc  = "Extract Method" },
                { "<leader>jt",  desc  = "Test Method" },
                { "<leader>jT",  desc  = "Test Class" },
                { "<leader>ju",  desc  = "Update Config" },
                { "<leader>jC",  desc  = "Compile Only" },
                { "<leader>jX",  desc  = "Clean .class Files" },

                -- Run
                { "<leader>r",   group = "Run" },
                { "<leader>rj",  desc  = "Run Java (Multi-class)" },
                { "<leader>rjd", desc  = "Run Java + JDBC" },
                { "<leader>rjm", desc  = "Run Specific Main Class" },
                { "<leader>rjp", desc  = "Run Java with Packages" },
                { "<leader>rc",  desc  = "Run C" },
                { "<leader>rp",  desc  = "Run Python" },
                { "<leader>rph", desc  = "Run PHP" },

                -- Live server
                { "<leader>l",   group = "Live" },
                { "<leader>ls",  desc  = "Toggle Live Server" },

                -- Git
                { "<leader>g",   group = "Git" },
                { "<leader>gh",  desc  = "Preview Hunk" },
                { "<leader>gb",  desc  = "Blame" },
                { "<leader>gA",  desc  = "Add All" },
                { "<leader>ga",  desc  = "Add File" },
                { "<leader>gc",  desc  = "Commit" },
                { "<leader>gP",  desc  = "Push" },

                -- Maven
                { "<leader>m",   group = "Maven" },
                { "<leader>mc",  desc  = "Compile" },
                { "<leader>mr",  desc  = "Run" },
                { "<leader>mt",  desc  = "Test" },
                { "<leader>mp",  desc  = "Package" },
                { "<leader>mC",  desc  = "Clean" },
                { "<leader>mi",  desc  = "Install" },

                -- Buffers (barbar)
                { "<leader>b",   group = "Buffers" },
                { "<leader>bh",  desc  = "Previous Buffer" },
                { "<leader>bl",  desc  = "Next Buffer" },
                { "<leader>bc",  desc  = "Close Buffer" },
                { "<leader>bp",  desc  = "Pin Buffer" },
                { "<leader>bb",  desc  = "Pick Buffer" },
                { "<leader>bd",  desc  = "Delete Buffer" },
                { "<leader>b<",  desc  = "Move Left" },
                { "<leader>b>",  desc  = "Move Right" },

                -- Buffer sorting
                { "<leader>bs",  group = "Sort Buffers" },
                { "<leader>bsn", desc  = "By Number" },
                { "<leader>bsf", desc  = "By Name" },
                { "<leader>bsd", desc  = "By Directory" },
                { "<leader>bsl", desc  = "By Language" },
                { "<leader>bsw", desc  = "By Window" },

                -- Comment
                { "<leader>/",   desc  = "Toggle Comment" },
            })
        end,
    },
}
