-- =============================================================================
-- JAVA.LUA - JDTLS language server + DAP integration for Java
-- =============================================================================

return {
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },

        config = function()

            -- Get JDTLS jar, config dir, and lombok agent paths from Mason
            local function get_jdtls()
                local mason_registry = require("mason-registry")
                local jdtls_pkg      = mason_registry.get_package("jdtls")
                local jdtls_path     = jdtls_pkg:get_install_path()
                local launcher       = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
                local config         = jdtls_path .. "/config_linux"
                local lombok         = jdtls_path .. "/lombok.jar"
                return launcher, config, lombok
            end

            -- Collect debug/test JARs from Mason
            local function get_bundles()
                local mason_registry = require("mason-registry")

                local java_debug      = mason_registry.get_package("java-debug-adapter")
                local java_debug_path = java_debug:get_install_path()
                local bundles         = {
                    vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
                }

                local java_test      = mason_registry.get_package("java-test")
                local java_test_path = java_test:get_install_path()
                vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

                return bundles
            end

            -- Use a per-project workspace directory
            local function get_workspace()
                local home         = os.getenv("HOME")
                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
                return home .. "/.local/share/nvim/jdtls-workspace/" .. project_name
            end

            -- Java-specific keymaps (buffer-local)
            local function java_keymaps(bufnr)
                local opts = { buffer = bufnr, noremap = true, silent = true }

                vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
                vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
                vim.cmd("command! -buffer JdtBytecode     lua require('jdtls').javap()")
                vim.cmd("command! -buffer JdtJshell       lua require('jdtls').jshell()")

                vim.keymap.set("n", "<leader>jo", "<Cmd>lua require('jdtls').organize_imports()<CR>",        vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
                vim.keymap.set("n", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>",        vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
                vim.keymap.set("v", "<leader>jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
                vim.keymap.set("n", "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>",        vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
                vim.keymap.set("v", "<leader>jc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
                vim.keymap.set("n", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Method" }))
                vim.keymap.set("v", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", vim.tbl_extend("force", opts, { desc = "Extract Method" }))
                vim.keymap.set("n", "<leader>jt", "<Cmd>lua require('jdtls').test_nearest_method()<CR>",     vim.tbl_extend("force", opts, { desc = "Test Method" }))
                vim.keymap.set("v", "<leader>jt", "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>", vim.tbl_extend("force", opts, { desc = "Test Method" }))
                vim.keymap.set("n", "<leader>jT", "<Cmd>lua require('jdtls').test_class()<CR>",              vim.tbl_extend("force", opts, { desc = "Test Class" }))
                vim.keymap.set("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>",                                vim.tbl_extend("force", opts, { desc = "Update Config" }))
            end

            -- Main JDTLS setup function (called per Java buffer)
            local function setup_jdtls()
                local jdtls         = require("jdtls")
                local launcher, os_config, lombok = get_jdtls()
                local workspace_dir = get_workspace()
                local bundles       = get_bundles()
                local root_dir      = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

                local capabilities  = require("cmp_nvim_lsp").default_capabilities()
                capabilities.workspace                                    = capabilities.workspace or {}
                capabilities.workspace.configuration                      = true
                capabilities.textDocument                                 = capabilities.textDocument or {}
                capabilities.textDocument.completion                      = capabilities.textDocument.completion or {}
                capabilities.textDocument.completion.snippetSupport       = true

                local extendedClientCapabilities = jdtls.extendedClientCapabilities
                extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                local cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xmx1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-javaagent:" .. lombok,
                    "-jar",          launcher,
                    "-configuration", os_config,
                    "-data",          workspace_dir,
                }

                local settings = {
                    java = {
                        format = {
                            enabled  = true,
                            settings = { profile = "GoogleStyle" },
                        },
                        eclipse          = { downloadSource = true },
                        maven            = { downloadSources = true },
                        signatureHelp    = { enabled = true },
                        contentProvider  = { preferred = "fernflower" },
                        saveActions      = { organizeImports = true },
                        completion = {
                            favoriteStaticMembers = {
                                "org.junit.jupiter.api.Assertions.*",
                                "java.util.Objects.requireNonNull",
                                "java.util.Objects.requireNonNullElse",
                            },
                            filteredTypes = { "com.sun.*", "java.awt.*", "jdk.*", "sun.*" },
                            importOrder   = { "java", "javax", "com", "org" },
                        },
                        sources = {
                            organizeImports = { starThreshold = 9999, staticThreshold = 9999 },
                        },
                        codeGeneration = {
                            toString       = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
                            hashCodeEquals = { useJava7Objects = true },
                            useBlocks      = true,
                        },
                        configuration    = { updateBuildConfiguration = "interactive" },
                        referencesCodeLens = { enabled = true },
                        inlayHints       = { parameterNames = { enabled = "all" } },
                    },
                }

                local on_attach = function(_, bufnr)
                    java_keymaps(bufnr)
                    jdtls.setup_dap({ hotcodereplace = "auto" })
                    jdtls.setup_dap_main_class_configs()
                    require("jdtls.setup").add_commands()
                    vim.lsp.codelens.refresh()

                    vim.api.nvim_create_autocmd("BufWritePost", {
                        buffer   = bufnr,
                        callback = function() pcall(vim.lsp.codelens.refresh) end,
                    })
                end

                jdtls.start_or_attach({
                    cmd          = cmd,
                    root_dir     = root_dir,
                    settings     = settings,
                    capabilities = capabilities,
                    init_options = {
                        bundles                   = bundles,
                        extendedClientCapabilities = extendedClientCapabilities,
                    },
                    on_attach = on_attach,
                })
            end

            -- Auto-start JDTLS whenever a Java file is opened
            vim.api.nvim_create_autocmd("FileType", {
                pattern  = "java",
                callback = setup_jdtls,
            })
        end,
    },
}
