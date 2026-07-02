--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/lsp/lsp.lua
--
-- Purpose:
--   Plugin specification for the Language Intelligence Engine.
--
-- Subsystem:  LSP
-- Adapters:   mason.nvim, mason-lspconfig.nvim, nvim-lspconfig
--
-- Responsibilities:
--   • Declare Mason + mason-lspconfig + lspconfig dependency chain.
--   • Wire together: Mason (installer) → mason-lspconfig (bridge) →
--     lspconfig (server config) → cmp-nvim-lsp (capabilities).
--   • Delegate server list to config/servers.lua.
--   • Delegate keymaps to config/keymaps.lua.
--   • Delegate diagnostic UI to config/diagnostics.lua.
--
-- Notes:
--   INITIALIZATION ORDER (critical):
--     1. Platform Spoofing       — must hook before setup if on Termux
--     2. mason.setup()           — must run first
--     3. Build LSP capabilities  — from cmp_nvim_lsp
--     4. Mason-lspconfig setup   — installs servers and configures wrappers
--     5. LspAttach autocmd       — registers keymaps per buffer
--     6. diagnostics.setup()     — configures diagnostic UI
--------------------------------------------------------------------------------

return {

    "neovim/nvim-lspconfig",

    -- Preserved exactly for instant syntax highlighting upon loading a buffer
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },

    config = function()

        local servers     = require("plugins.lsp.config.servers")
        local lsp_keymaps = require("plugins.lsp.config.keymaps")
        local diagnostics = require("plugins.lsp.config.diagnostics")

        --------------------------------------------------------------------
        -- 1. Mason Platform Override for Termux
        --------------------------------------------------------------------
        if vim.env.TERMUX_VERSION then
            -- Fool Mason into pulling down standard Linux aarch64 binary packages
            -- rather than throwing an "unsupported platform" guard fault.
            local platform = require("mason-core.platform")
            platform.is_android = false
            platform.is_linux = true
            platform.arch = "aarch64"
        end

        --------------------------------------------------------------------
        -- 2. Mason Core Setup
        --------------------------------------------------------------------
        require("mason").setup({
            ui = {
                border = require("core.constants").UI.BORDER,
                icons  = {
                    package_installed   = "✓",
                    package_pending     = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        --------------------------------------------------------------------
        -- 3. Build LSP Capabilities
        --------------------------------------------------------------------
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        --------------------------------------------------------------------
        -- 4. Mason-lspconfig & Runtime JIT Command Interceptors
        --------------------------------------------------------------------
        local handlers = {
            -- Default handler called for every server without a custom entry
            function(server_name)
                local lspconfig = require("lspconfig")
                
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_new_config = function(config, _)
                        if vim.env.TERMUX_VERSION and config.cmd and config.cmd[1] then
                            -- Intercept server execution right before boot if located in Mason storage
                            if config.cmd[1]:match("%.local/share/nvim/mason") then
                                -- Synchronously fix the binary linker to glibc on disk
                                vim.fn.system(string.format("patchelf --set-interpreter $PREFIX/glibc/lib/ld-linux-aarch64.so.1 %s 2>/dev/null", config.cmd[1]))
                                -- Inject the glibc-runner execution wrapper if present
                                if vim.fn.executable("grun") == 1 then
                                    table.insert(config.cmd, 1, "grun")
                                end
                            end
                        end
                    end
                })
            end,
        }

        -- Inject the shared capabilities object into each custom handler
        for name, handler in pairs(servers.handlers) do
            handlers[name] = function()
                handler(capabilities)
            end
        end

        require("mason-lspconfig").setup({
            ensure_installed       = servers.ensure_installed,
            automatic_installation = true,
            handlers               = handlers,
        })

        --------------------------------------------------------------------
        -- 5. LspAttach — Register Keymaps
        --------------------------------------------------------------------
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("PDELspAttach", { clear = true }),
            desc = "Register buffer-local LSP keymaps on attach",
            callback = function(event)
                lsp_keymaps.on_attach(event.buf)
            end,
        })

        --------------------------------------------------------------------
        -- 6. Diagnostic UI
        --------------------------------------------------------------------
        diagnostics.setup()

    end,

}
