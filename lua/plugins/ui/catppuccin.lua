--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/plugins/ui/catppuccin.lua
--------------------------------------------------------------------------------

return {

    "catppuccin/nvim",

    name = "catppuccin",

    priority = 1000,

    lazy = false,

    opts = function()
        return require("plugins.ui.config.theme")
    end,

}
