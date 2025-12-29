return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
        "mfussenegger/nvim-dap",
        "williamboman/mason.nvim",
    },
    config = function()
        -- Helper function to get JDTLS paths
        local function get_jdtls()
            local mason_registry = require("mason-registry")
            local jdtls = mason_registry.get_package("jdtls")
            local jdtls_path = jdtls:get_install_path()
            local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
            local SYSTEM = "linux"
            local config = jdtls_path .. "/config_" .. SYSTEM
            local lombok = jdtls_path .. "/lombok.jar"
            return launcher, config, lombok
        end

        -- Helper function to get debug/test bundles
        local function get_bundles()
            local mason_registry = require("mason-registry")

            -- Java Debug Adapter
            local java_debug = mason_registry.get_package("java-debug-adapter")
            local java_debug_path = java_debug:get_install_path()
            local bundles = {
                vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
            }

            -- Java Test
            local java_test = mason_registry.get_package("java-test")
            local java_test_path = java_test:get_install_path()
            vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))

            return bundles
        end

        -- Helper function to get workspace directory
        local function get_workspace()
            local home = os.getenv("HOME")
            local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = workspace_path .. project_name
            return workspace_dir
        end

        -- Java-specific keymaps
        local function java_keymaps(bufnr)
            local opts = { buffer = bufnr, noremap = true, silent = true }

            -- Commands
            vim.cmd(
                "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
            vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
            vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
            vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

            -- Keymaps
            vim.keymap.set('n', '<leader>jo', "<Cmd>lua require('jdtls').organize_imports()<CR>",
                vim.tbl_extend("force", opts, { desc = "Organize imports" }))
            vim.keymap.set('n', '<leader>jv', "<Cmd>lua require('jdtls').extract_variable()<CR>",
                vim.tbl_extend("force", opts, { desc = "Extract variable" }))
            vim.keymap.set('v', '<leader>jv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                vim.tbl_extend("force", opts, { desc = "Extract variable" }))
            vim.keymap.set('n', '<leader>jc', "<Cmd>lua require('jdtls').extract_constant()<CR>",
                vim.tbl_extend("force", opts, { desc = "Extract constant" }))
            vim.keymap.set('v', '<leader>jc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
                vim.tbl_extend("force", opts, { desc = "Extract constant" }))
            vim.keymap.set('n', '<leader>jm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                vim.tbl_extend("force", opts, { desc = "Extract method" }))
            vim.keymap.set('v', '<leader>jm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                vim.tbl_extend("force", opts, { desc = "Extract method" }))

            -- Testing
            vim.keymap.set('n', '<leader>jt', "<Cmd>lua require('jdtls').test_nearest_method()<CR>",
                vim.tbl_extend("force", opts, { desc = "Test method" }))
            vim.keymap.set('v', '<leader>jt', "<Esc><Cmd>lua require('jdtls').test_nearest_method(true)<CR>",
                vim.tbl_extend("force", opts, { desc = "Test method" }))
            vim.keymap.set('n', '<leader>jT', "<Cmd>lua require('jdtls').test_class()<CR>",
                vim.tbl_extend("force", opts, { desc = "Test class" }))

            -- Update config
            vim.keymap.set('n', '<leader>ju', "<Cmd>JdtUpdateConfig<CR>",
                vim.tbl_extend("force", opts, { desc = "Update config" }))
        end

        -- Setup JDTLS
        local function setup_jdtls()
            local jdtls = require("jdtls")
            local launcher, os_config, lombok = get_jdtls()
            local workspace_dir = get_workspace()
            local bundles = get_bundles()
            local root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })

            -- Capabilities
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.workspace = capabilities.workspace or {}
            capabilities.workspace.configuration = true
            capabilities.textDocument = capabilities.textDocument or {}
            capabilities.textDocument.completion = capabilities.textDocument.completion or {}
            capabilities.textDocument.completion.snippetSupport = false

            local extendedClientCapabilities = jdtls.extendedClientCapabilities
            extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

            -- Command
            local cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xmx1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                '-javaagent:' .. lombok,
                '-jar', launcher,
                '-configuration', os_config,
                '-data', workspace_dir
            }

            -- Settings
            local settings = {
                java = {
                    format = {
                        enabled = true,
                        settings = {
                            profile = "GoogleStyle"
                        }
                    },
                    eclipse = { downloadSource = true },
                    maven = { downloadSources = true },
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = "fernflower" },
                    saveActions = { organizeImports = true },
                    completion = {
                        favoriteStaticMembers = {
                            "org.junit.jupiter.api.Assertions.*",
                            "java.util.Objects.requireNonNull",
                            "java.util.Objects.requireNonNullElse",
                        },
                        filteredTypes = {
                            "com.sun.*",
                            "java.awt.*",
                            "jdk.*",
                            "sun.*",
                        },
                        importOrder = {
                            "java",
                            "javax",
                            "com",
                            "org",
                        }
                    },
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticThreshold = 9999
                        }
                    },
                    codeGeneration = {
                        toString = {
                            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                        },
                        hashCodeEquals = { useJava7Objects = true },
                        useBlocks = true
                    },
                    configuration = { updateBuildConfiguration = "interactive" },
                    referencesCodeLens = { enabled = true },
                    inlayHints = {
                        parameterNames = { enabled = "all" }
                    }
                }
            }

            -- On attach
            local on_attach = function(_, bufnr)
                java_keymaps(bufnr)

                -- Setup DAP
                jdtls.setup_dap({ hotcodereplace = "auto" })
                jdtls.setup_dap_main_class_configs()

                -- Add commands
                require('jdtls.setup').add_commands()

                -- Refresh code lens
                vim.lsp.codelens.refresh()

                -- Auto-refresh code lens on save
                vim.api.nvim_create_autocmd("BufWritePost", {
                    buffer = bufnr,
                    callback = function()
                        pcall(vim.lsp.codelens.refresh)
                    end
                })
            end

            -- Config
            local config = {
                cmd = cmd,
                root_dir = root_dir,
                settings = settings,
                capabilities = capabilities,
                init_options = {
                    bundles = bundles,
                    extendedClientCapabilities = extendedClientCapabilities
                },
                on_attach = on_attach
            }

            -- Start JDTLS
            jdtls.start_or_attach(config)
        end

        -- Auto-setup on Java files
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = setup_jdtls
        })
    end,
}
