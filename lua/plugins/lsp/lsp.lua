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
--     4. mason-lspconfig.setup() — installs servers, runs handlers
--     5. LspAttach autocmd       — registers keymaps per buffer
--     6. diagnostics.setup()     — configures diagnostic UI
--------------------------------------------------------------------------------

return {

    "neovim/nvim-lspconfig",

    event = { "BufReadPost", "BufNewFile" },

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
        -- 2. Mason Core Setup & Post-Install ELF Interpreter Patching
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

        if vim.env.TERMUX_VERSION then
            local registry = require("mason-registry")
            registry.refresh(function()
                registry.on("package:install:success", function(pkg)
                    local install_dir = pkg:get_install_path()
                    -- Instantly target any newly installed compiled binaries and patch their dynamic link loader path to glibc
                    vim.fn.jobstart(
                        string.format("find %s -type f -executable -exec patchelf --set-interpreter $PREFIX/glibc/lib/ld-linux-aarch64.so.1 {} \\;", install_dir),
                        { detach = true }
                    )
                end)
            end)
        end

        --------------------------------------------------------------------
        -- 3. Build LSP Capabilities
        --------------------------------------------------------------------

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        --------------------------------------------------------------------
        -- 4. Mason-lspconfig & Intercept Execution Wrapper
        --------------------------------------------------------------------

        if vim.env.TERMUX_VERSION then
            local util = require('lspconfig.util')
            util.on_setup = util.add_hook_before(util.on_setup, function(config)
                -- If execution target targets a Mason package utility path, wrap execution via the glibc-runner subshell
                if config.cmd and config.cmd[1] and config.cmd[1]:match("%.local/share/nvim/mason") then
                    table.insert(config.cmd, 1, "grun")
                end
            end)
        end

        -- Build the handlers table:
        local handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
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

