--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/git/init.lua
--
-- Purpose:
--   Git subsystem manifest.
--
-- Responsibilities:
--   • Register all Git plugin specifications for Lazy.nvim.
--
-- Adapters registered here:
--   • gitsigns.nvim   — hunk-level: gutter signs, staging, blame, navigation
--   • vim-fugitive    — repo-level: status, commit, push, pull, log
--
-- Notes:
--   Plugin specifications are intentionally separate from their
--   implementation details. No configuration logic lives here.
--
--   Both adapters own different layers of the git workflow:
--     gitsigns → fine-grained hunk operations
--     fugitive → high-level repo operations and the :Git TUI
--------------------------------------------------------------------------------

return {

    require("plugins.git.gitsigns"),

    require("plugins.git.fugitive"),

}
