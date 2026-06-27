--------------------------------------------------------------------------------
-- Neovim IDE
--------------------------------------------------------------------------------
-- File: lua/config/commands.lua
--
-- Purpose:
--   Registers custom user commands.
--
-- Responsibilities:
--   • Development utilities
--   • Workflow commands
--   • SchoolPulse commands (future)
--
-- Notes:
--   Keep commands editor-agnostic whenever possible.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Local Aliases
--------------------------------------------------------------------------------

local api = vim.api

--------------------------------------------------------------------------------
-- User Commands
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Reload Configuration
--------------------------------------------------------------------------------
--
-- Reloads the current Neovim configuration without restarting.
--------------------------------------------------------------------------------

api.nvim_create_user_command(

    "ReloadConfig",

    function()

        for name in pairs(package.loaded) do

            if name:match("^config") or name:match("^plugins") then
                package.loaded[name] = nil
            end

        end

        dofile(vim.env.MYVIMRC)

        vim.notify("Neovim configuration reloaded.", vim.log.levels.INFO)

    end,

    {

        desc = "Reload Neovim configuration",

    }

)
