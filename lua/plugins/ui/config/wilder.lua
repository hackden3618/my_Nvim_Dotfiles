--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/ui/config/wilder.lua
--
-- Purpose:
--   Configuration for the Command Completion adapter (wilder.nvim).
--
-- Responsibilities:
--   • Define which command-line modes receive completion (: / ?).
--   • Configure the Lua-only fuzzy pipeline (no Python required).
--   • Configure the popup renderer appearance.
--
-- Notes:
--   ARCHITECTURE DECISION — Lua-only pipeline:
--   wilder supports two fuzzy filter backends:
--     • wilder.vim_fuzzy_filter()   → requires Python + pynvim
--     • wilder.lua_fzy_filter()     → pure Lua, no external dependency
--
--   We use lua_fzy_filter() to keep the PDE self-contained and avoid
--   requiring pynvim as a system dependency. Performance is equivalent
--   for typical command-line completion use cases.
--
--   ARCHITECTURE DECISION — popupmenu renderer without border theme:
--   The border theme renderer adds visual chrome but costs additional
--   rendering work. The standard popupmenu_renderer is used to keep
--   the command-line UI lightweight.
--------------------------------------------------------------------------------

local M = {}

--------------------------------------------------------------------------------
-- Public API
--------------------------------------------------------------------------------

--- Initialize wilder with the Lua-only pipeline and popup renderer.
--- Called from the plugin spec's config function.
function M.setup()

    local wilder = require("wilder")

    --------------------------------------------------------------------------
    -- Modes
    --------------------------------------------------------------------------
    --
    -- Activate wilder in:
    --   :  Command mode
    --   /  Forward search
    --   ?  Backward search
    --------------------------------------------------------------------------

    wilder.setup({ modes = { ":", "/", "?" } })

    --------------------------------------------------------------------------
    -- Pipeline — Lua-only fuzzy matching
    --------------------------------------------------------------------------
    --
    -- Uses lua_fzy_filter() for fuzzy matching with zero Python dependency.
    -- Falls back to vim_search_pipeline for / and ? modes.
    --------------------------------------------------------------------------

    wilder.set_option("pipeline", {
        wilder.branch(
            wilder.cmdline_pipeline({
                fuzzy        = 1,
                fuzzy_filter = wilder.lua_fzy_filter(),
            }),
            wilder.vim_search_pipeline()
        ),
    })

    --------------------------------------------------------------------------
    -- Renderer — Lightweight popup menu
    --------------------------------------------------------------------------

    wilder.set_option("renderer", wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
            highlighter = wilder.lua_fzy_highlighter(),
            highlights  = {
                border = "Normal", -- or any highlight group like "FloatBorder"
                accent = wilder.make_hl(
                    "WilderAccent",
                    "Pmenu",
                    { { a = 1 }, { a = 1 }, { foreground = "#cba6f7" } }
                ),
            },
            border = "rounded",
            left  = { " ", wilder.popupmenu_devicons() },
            right = { " ", wilder.popupmenu_scrollbar() },
            pumblend = 10,
        })
    ))

end

return M
