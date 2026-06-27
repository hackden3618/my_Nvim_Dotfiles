--------------------------------------------------------------------------------
-- Neovim PDE
--------------------------------------------------------------------------------
-- File: lua/core/keymaps.lua
--------------------------------------------------------------------------------

local M = {}

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Internal Helper
--------------------------------------------------------------------------------

local function defaults(desc)
    return {
        noremap = true,
        silent = true,
        desc = desc,
    }
end

--------------------------------------------------------------------------------
-- Public API
--------------------------------------------------------------------------------

function M.n(lhs, rhs, desc, opts)
    map("n", lhs, rhs, vim.tbl_extend("force", defaults(desc), opts or {}))
end

function M.i(lhs, rhs, desc, opts)
    map("i", lhs, rhs, vim.tbl_extend("force", defaults(desc), opts or {}))
end

function M.v(lhs, rhs, desc, opts)
    map("v", lhs, rhs, vim.tbl_extend("force", defaults(desc), opts or {}))
end

function M.t(lhs, rhs, desc, opts)
    map("t", lhs, rhs, vim.tbl_extend("force", defaults(desc), opts or {}))
end

return M
