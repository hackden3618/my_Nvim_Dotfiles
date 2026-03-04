-- =============================================================================
-- DAP.LUA - Debug Adapter Protocol (C/C++ via codelldb, Java via jdtls)
-- =============================================================================

return {
    -- Core DAP engine + UI
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",          -- visual debugger UI
            "theHamsta/nvim-dap-virtual-text", -- inline variable values
            "nvim-neotest/nvim-nio",           -- async IO (required by dap-ui)
        },

        config = function()
            local dap    = require("dap")
            local dapui  = require("dapui")

            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            -- Auto open/close DAP UI when debugging starts/ends
            dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open()  end
            dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end

            -- Keymaps
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,  { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue,           { desc = "Start/Continue" })
            vim.keymap.set("n", "<leader>di", dap.step_into,          { desc = "Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_over,          { desc = "Step Over" })
            vim.keymap.set("n", "<leader>dO", dap.step_out,           { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dt", dap.terminate,          { desc = "Terminate" })
            vim.keymap.set("n", "<leader>du", dapui.toggle,           { desc = "Toggle DAP UI" })

            -- C/C++ adapter (codelldb via Mason)
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args    = { "--port", "${port}" },
                },
            }

            dap.configurations.c = {
                {
                    name    = "Launch file",
                    type    = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd         = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            dap.configurations.cpp = dap.configurations.c

            -- Java (handled by jdtls — see java.lua)
            dap.configurations.java = {
                {
                    type     = "java",
                    request  = "launch",
                    name     = "Debug (Attach) - Remote",
                    hostName = "127.0.0.1",
                    port     = 5005,
                },
            }
        end,
    },

    -- Mason adapter installer
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed    = { "codelldb", "java-debug-adapter", "java-test" },
                automatic_installation = true,
            })
        end,
    },
}
