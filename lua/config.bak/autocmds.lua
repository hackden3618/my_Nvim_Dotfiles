--------------------------------------------------------------------------------
-- Neovim IDE
--------------------------------------------------------------------------------
-- File: lua/config/autocmds.lua
--
-- Purpose:
--   Registers editor-wide automatic commands.
--
-- Responsibilities:
--   • Highlight on yank
--   • Restore cursor position
--   • Resize splits
--   • Remove whitespace (future)
--
-- Notes:
--   Plugin-specific autocommands belong inside the plugin configuration.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Local Aliases
--------------------------------------------------------------------------------

local api = vim.api

--------------------------------------------------------------------------------
-- Autocommand Groups
--------------------------------------------------------------------------------

local general_group = api.nvim_create_augroup("General", { clear = true })

--------------------------------------------------------------------------------
-- Highlight Yank
--------------------------------------------------------------------------------
--
-- Briefly highlights text after it has been yanked.
--------------------------------------------------------------------------------

api.nvim_create_autocmd("TextYankPost", {

    group = general_group,

    desc = "Highlight yanked text",

    callback = function()

        vim.highlight.on_yank({

            higroup = "IncSearch",
            timeout = 200,

        })

    end,

})

--------------------------------------------------------------------------------
-- Restore Cursor Position
--------------------------------------------------------------------------------
--
-- Reopens files at the last cursor location.
--------------------------------------------------------------------------------

api.nvim_create_autocmd("BufReadPost", {

    group = general_group,

    desc = "Restore previous cursor position",

    callback = function(event)

        local mark = api.nvim_buf_get_mark(event.buf, '"')

        local line_count = api.nvim_buf_line_count(event.buf)

        if mark[1] > 0 and mark[1] <= line_count then
            pcall(api.nvim_win_set_cursor, 0, mark)
        end

    end,

})

--------------------------------------------------------------------------------
-- Equalize Splits
--------------------------------------------------------------------------------
--
-- Automatically resize all windows when Neovim itself is resized.
--------------------------------------------------------------------------------

api.nvim_create_autocmd("VimResized", {

    group = general_group,

    desc = "Resize splits equally",

    command = "tabdo wincmd =",

})
