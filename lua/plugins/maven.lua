-- =============================================================================
-- MAVEN.LUA - Maven build tool keymaps
-- =============================================================================

return {
    {
        "nvim-lua/plenary.nvim",
        lazy = false,

        config = function()
            local function mvn(cmd, desc)
                vim.keymap.set("n", "<leader>m" .. cmd[1], function()
                    vim.cmd("split | term mvn " .. cmd[2])
                end, { desc = "Maven: " .. desc })
            end

            mvn({ "c", "clean compile" }, "Compile")
            mvn({ "r", "exec:java"      }, "Run")
            mvn({ "t", "test"           }, "Test")
            mvn({ "p", "package"        }, "Package")
            mvn({ "C", "clean"          }, "Clean")
            mvn({ "i", "clean install"  }, "Install")
        end,
    },
}
