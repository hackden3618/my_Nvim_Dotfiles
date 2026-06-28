--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/ui/init.lua
--
-- Purpose:
--   UI subsystem manifest.
--
-- Responsibilities:
--   • Register all UI plugin specifications for Lazy.nvim.
--
-- Subsystems registered here:
--   • Theme Engine     → catppuccin (visual identity)
--   • Command Engine   → which-key (keymap discoverability)
--   • Status Engine    → lualine   (statusline)
--   • Buffer Engine    → barbar    (buffer tabline)
--   • Command Completion → wilder  (enhanced : / ? completion)
--
-- Notes:
--   Plugin specifications are intentionally separate from their
--   implementation details. No configuration logic lives here.
--------------------------------------------------------------------------------

return {

    require("plugins.ui.catppuccin"),

    require("plugins.ui.which-key"),

    require("plugins.ui.lualine"),

    require("plugins.ui.barbar"),

    require("plugins.ui.wilder"),

}
