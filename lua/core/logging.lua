--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/core/logging.lua
--------------------------------------------------------------------------------

local M = {}

local notify = vim.notify

local levels = vim.log.levels

function M.info(message)
    notify(message, levels.INFO)
end

function M.warn(message)
    notify(message, levels.WARN)
end

function M.error(message)
    notify(message, levels.ERROR)
end

function M.success(message)
    notify(message, levels.INFO, {
        title = "Success",
    })
end

return M
