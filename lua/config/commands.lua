--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/config/commands.lua
--
-- Purpose:
--   Registers custom user commands for the PDE.
--
-- Responsibilities:
--   • Configuration reload command
--   • Core module cache inspection (development utility)
--
-- Notes:
--   Keep commands editor-agnostic whenever possible.
--   Plugin-specific commands belong inside the plugin configuration.
--   Uses core.logging for all notifications.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Imports
--------------------------------------------------------------------------------

local api     = vim.api
local logging = require("core.logging")

--------------------------------------------------------------------------------
-- Reload Configuration
--------------------------------------------------------------------------------
--
-- Reloads the current Neovim configuration without restarting.
-- Clears all config/* and core/* module caches before re-running
-- the main init file.
--
-- Note: Plugin state (lazy-loaded plugins) is NOT reset by this command.
-- For a full plugin reset, use :Lazy reload <name>.
--------------------------------------------------------------------------------

api.nvim_create_user_command(

    "ReloadConfig",

    function()

        for name in pairs(package.loaded) do
            if name:match("^config") or name:match("^core") or name:match("^plugins") then
                package.loaded[name] = nil
            end
        end

        dofile(vim.env.MYVIMRC)

        logging.success("Configuration reloaded.", "PDE")

    end,

    { desc = "Reload Neovim configuration without restarting" }

)

--------------------------------------------------------------------------------
-- Inspect Core
--------------------------------------------------------------------------------
--
-- Opens a scratch buffer with the contents of require("core") printed
-- in a human-readable form. Useful during development to confirm that
-- all core modules are loading correctly.
--------------------------------------------------------------------------------

api.nvim_create_user_command(

    "PDEInspectCore",

    function()

        local core = require("core")
        local lines = { "-- PDE Core Inspection --", "" }

        for key, value in pairs(core) do
            table.insert(lines, ("  %-12s = %s"):format(key, tostring(value)))
        end

        local buf = api.nvim_create_buf(false, true)
        api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].filetype = "lua"
        api.nvim_win_set_buf(0, buf)

    end,

    { desc = "Inspect the PDE core module table in a scratch buffer" }

)
