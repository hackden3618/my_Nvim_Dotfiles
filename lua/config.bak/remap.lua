--------------------------------------------------------------------------------
-- Neovim IDE
--------------------------------------------------------------------------------
-- File: lua/config/remap.lua
--
-- Purpose:
--   Registers global editor keymaps.
--
-- Responsibilities:
--   • Window management
--   • Terminal management
--   • Search utilities
--   • Editing convenience
--   • Navigation
--
-- Notes:
--   Plugin-specific mappings belong inside the corresponding plugin module.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Local Aliases
--------------------------------------------------------------------------------

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Helper Functions
--------------------------------------------------------------------------------

--- Create common keymap options.
---
--- @param desc string Human-readable description.
--- @return table
local function keymap_opts(desc)
    return {
        noremap = true,
        silent = true,
        desc = desc,
    }
end

--------------------------------------------------------------------------------
-- File Explorer
--------------------------------------------------------------------------------

map(
    "n",
    "<leader>pv",
    vim.cmd.Ex,
    keymap_opts("Open netrw Explorer")
)

--------------------------------------------------------------------------------
-- Escape Shortcuts
--------------------------------------------------------------------------------

map(
    "i",
    "jj",
    "<Esc>",
    keymap_opts("Exit Insert Mode")
)

map(
    "v",
    "jk",
    "<Esc>",
    keymap_opts("Exit Visual Mode")
)

--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------

map(
    "n",
    "<Esc>",
    "<cmd>nohlsearch<CR>",
    keymap_opts("Clear Search Highlight")
)

--------------------------------------------------------------------------------
-- Window Management
--------------------------------------------------------------------------------

map(
    "n",
    "<leader>wv",
    "<cmd>vsplit<CR>",
    keymap_opts("Vertical Split")
)

map(
    "n",
    "<leader>wb",
    "<cmd>split<CR>",
    keymap_opts("Horizontal Split")
)

map(
    "n",
    "<leader>wc",
    "<cmd>close<CR>",
    keymap_opts("Close Window")
)

--------------------------------------------------------------------------------
-- Window Navigation
--------------------------------------------------------------------------------

map(
    "n",
    "<leader>wh",
    "<C-w>h",
    keymap_opts("Focus Left Window")
)

map(
    "n",
    "<leader>wj",
    "<C-w>j",
    keymap_opts("Focus Lower Window")
)

map(
    "n",
    "<leader>wk",
    "<C-w>k",
    keymap_opts("Focus Upper Window")
)

map(
    "n",
    "<leader>wl",
    "<C-w>l",
    keymap_opts("Focus Right Window")
)

--------------------------------------------------------------------------------
-- Terminal
--------------------------------------------------------------------------------

map(
    "n",
    "<leader>tO",
    "<cmd>terminal<CR>",
    keymap_opts("Open Terminal")
)

--------------------------------------------------------------------------------
-- Better Line Movement
--------------------------------------------------------------------------------

map(
    "n",
    "J",
    "mzJ`z",
    keymap_opts("Join Lines")
)

map(
    "n",
    "<C-d>",
    "<C-d>zz",
    keymap_opts("Half Page Down")
)

map(
    "n",
    "<C-u>",
    "<C-u>zz",
    keymap_opts("Half Page Up")
)

map(
    "n",
    "n",
    "nzzzv",
    keymap_opts("Next Search Result")
)

map(
    "n",
    "N",
    "Nzzzv",
    keymap_opts("Previous Search Result")
)

--------------------------------------------------------------------------------
-- End of File
--------------------------------------------------------------------------------
