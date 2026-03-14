-- ==========================================
-- SURROUND.LUA - Surround text with quotes, brackets, etc.
-- ==========================================
-- Save as: lua/plugins/surround.lua

return {
    {
        "kylechui/nvim-surround",
        version = "*",     -- Use latest stable release
        event = "VeryLazy",
    },
}

-- ==========================================
-- EXAMPLES FOR SURROUND:
-- ==========================================
-- ys + motion + char:  Surround with char
--   ysiw"              Surround word with "
--   yss)               Surround line with ()
--   ys$}               Surround to end of line with {}
--
-- Visual mode:
--   Select text + S + char
--   viw S "            Surround word with "
--
-- Delete surroundings:
--   ds"                Delete surrounding "
--   ds(                Delete surrounding ()
--
-- Change surroundings:
--   cs"'               Change " to '
--   cs({               Change ( to {
-- ==========================================
