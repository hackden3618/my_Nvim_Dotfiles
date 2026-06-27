--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/ui/init.lua
--
-- Purpose:
--   UI subsystem manifest.
--
-- Responsibilities:
--   • Register all UI plugin specifications.
--
-- Notes:
--   Plugin specifications are intentionally separate from their
--   implementation details.
--------------------------------------------------------------------------------

return {

    require("plugins.ui.catppuccin"),

    require("plugins.ui.which-key"),

    require("plugins.ui.lualine"),

    require("plugins.ui.barbar"),

    require("plugins.ui.wilder"),

}
