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
            win = {
                border = "rounded",
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
            },
        })

        -- Register your leader key groups with descriptions
        wk.add({
            -- Project/File navigation
            { "<leader>p",   group = "Project" },

            -- Find (Telescope)
            { "<leader>f",   group = "Find" },

            -- Code/LSP
            { "<leader>c",   group = "Code" },
            { "<leader>cr",  desc = "Rename" },
            { "<leader>ca",  desc = "Code Actions" },
            { "<leader>cf",  desc = "Format" },

            -- Debugging
            { "<leader>d",   group = "Debug" },
            { "<leader>db",  desc = "Toggle Breakpoint" },
            { "<leader>dc",  desc = "Continue" },
            { "<leader>di",  desc = "Step Into" },
            { "<leader>do",  desc = "Step Over" },
            { "<leader>dO",  desc = "Step Out" },
            { "<leader>dt",  desc = "Terminate" },
            { "<leader>du",  desc = "Toggle UI" },

            -- Java specific
            { "<leader>j",   group = "Java" },
            { "<leader>jo",  desc = "Organize Imports" },
            { "<leader>jv",  desc = "Extract Variable" },
            { "<leader>jc",  desc = "Extract Constant" },
            { "<leader>jm",  desc = "Extract Method" },
            { "<leader>jt",  desc = "Test Method" },
            { "<leader>jT",  desc = "Test Class" },
            { "<leader>ju",  desc = "Update Config" },
            { "<leader>jC",  desc = "Compile Only" },
            { "<leader>jX",  desc = "Clean .class Files" },

            -- Run code
            { "<leader>r",   group = "Run" },
            { "<leader>rj",  desc = "Run Java (Multi-class)" },
            { "<leader>rjd", desc = "Run Java + JDBC" },
            { "<leader>rjm", desc = "Run Specific Main" },
            { "<leader>rjp", desc = "Run Java Package" },
            { "<leader>rc",  desc = "Run C" },
            { "<leader>rp",  desc = "Run Python" },

            -- Live server
            { "<leader>l",   group = "Live" },
            { "<leader>ls",  desc = "Toggle Live Server" },

            -- Git
            { "<leader>g",   group = "Git" },
            { "<leader>gh",  desc = "Preview Hunk" },
            { "<leader>gb",  desc = "Blame" },
            { "<leader>gA",  desc = "Add All" },
            { "<leader>ga",  desc = "Add File" },
            { "<leader>gc",  desc = "Commit" },
            { "<leader>gP",  desc = "Push" },

            -- Terminal
            { "<leader>t",   group = "Terminal" },
            { "<leader>tO",  desc = "Open Terminal" },

            -- Windows
            { "<leader>w",   group = "Windows" },
            { "<leader>wv",  desc = "Split Vertical" },
            { "<leader>wb",  desc = "Split Horizontal" },
            { "<leader>wh",  desc = "Focus Left" },
            { "<leader>wl",  desc = "Focus Right" },
            { "<leader>wj",  desc = "Focus Down" },
            { "<leader>wk",  desc = "Focus Up" },

            -- Tabs (Buffer bar)
            { "<leader>b",   group = "Buffers" },
            { "<leader>bh",  desc = "Previous Buffer" },
            { "<leader>bl",  desc = "Next Buffer" },
            { "<leader>bc",  desc = "Close Buffer" },
            { "<leader>bp",  desc = "Pin Buffer" },
            { "<leader>bb",  desc = "Pick Buffer" },
            { "<leader>bd",  desc = "Delete Buffer" },
            { "<leader>b<",  desc = "Move Left" },
            { "<leader>b>",  desc = "Move Right" },

            -- Buffer sorting
            { "<leader>bs",  group = "Sort Buffers" },
            { "<leader>bsn", desc = "By Number" },
            { "<leader>bsf", desc = "By Name" },
            { "<leader>bsd", desc = "By Directory" },
            { "<leader>bsl", desc = "By Language" },
            { "<leader>bsw", desc = "By Window" },

            -- Maven
            { "<leader>m",   group = "Maven" },
            { "<leader>mc",  desc = "Compile" },
            { "<leader>mr",  desc = "Run" },
            { "<leader>mt",  desc = "Test" },
            { "<leader>mp",  desc = "Package" },
            { "<leader>mC",  desc = "Clean" },
            { "<leader>mi",  desc = "Install" },

            -- Spring Boot
            -- { "<leader>s",   group = "Spring Boot" },
            -- { "<leader>sb",  desc = "Run (Maven)" },
            -- { "<leader>sg",  desc = "Run (Gradle)" },
            -- { "<leader>sj",  desc = "Build JAR" },
            -- { "<leader>sr",  desc = "Run JAR" },
            -- { "<leader>sc",  desc = "Clean & Run" },
            -- { "<leader>st",  desc = "Run Tests" },
            -- { "<leader>sn",  desc = "New Project" },
            -- { "<leader>sp",  desc = "Open Properties" },
            -- { "<leader>sk",  desc = "Kill (port 8080)" },

            -- Comment
            { "<leader>/",   desc = "Toggle Comment" },
        })
    end,
}
