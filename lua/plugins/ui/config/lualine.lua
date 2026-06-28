--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/ui/config/lualine.lua
--
-- Purpose:
--   Configuration for the Status Engine (lualine.nvim).
--
-- Responsibilities:
--   • Define statusline theme and section layout.
--   • Express visual identity through section composition.
--   • Show: mode, git branch, diagnostics, LSP name, filetype, position.
--
-- Notes:
--   The catppuccin theme integration is set here to match the PDE
--   visual identity. If the theme changes, only this file needs updating.
--
--   Section naming:
--     lualine_a: far left (mode)
--     lualine_b: left (git, branch)
--     lualine_c: center-left (filename, diff)
--     lualine_x: center-right (diagnostics, lsp, filetype)
--     lualine_y: right (progress)
--     lualine_z: far right (location)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

--- Show the active LSP server name for the current buffer.
--- Returns an empty string when no LSP is attached.
---
--- @return string
local function lsp_name()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    end
    -- Show the first client's name (jdtls, lua_ls, ts_ls, etc.)
    return "  " .. clients[1].name
end

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

local icons = require("core.icons")

return {

    --------------------------------------------------------------------------------
    -- Theme
    --------------------------------------------------------------------------------

    options = {
        theme                = "catppuccin-mocha",
        globalstatus         = true,
        section_separators   = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
    },

    --------------------------------------------------------------------------------
    -- Sections
    --------------------------------------------------------------------------------

    sections = {

        lualine_a = {
            {
                "mode",
                icon = icons.ui.lightning,
            },
        },

        lualine_b = {
            {
                "branch",
                icon = icons.git.branch,
            },
        },

        lualine_c = {
            {
                "filename",
                path   = 1,           -- Show relative path
                symbols = {
                    modified  = " " .. icons.git.modified,
                    readonly  = " " .. icons.ui.lock,
                    unnamed   = "[No Name]",
                    newfile   = " [New]",
                },
            },
            {
                "diff",
                symbols = {
                    added    = icons.git.added,
                    modified = icons.git.modified,
                    removed  = icons.git.removed,
                },
            },
        },

        lualine_x = {
            {
                "diagnostics",
                symbols = {
                    error = icons.diagnostics.Error,
                    warn  = icons.diagnostics.Warn,
                    hint  = icons.diagnostics.Hint,
                    info  = icons.diagnostics.Info,
                },
            },
            lsp_name,
            "filetype",
        },

        lualine_y = { "progress" },

        lualine_z = { "location" },

    },

    --------------------------------------------------------------------------------
    -- Inactive Windows
    --------------------------------------------------------------------------------

    inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
    },

}
