-- ==========================================
-- SURROUND.LUA - Surround text with quotes, brackets, etc.
-- ==========================================
-- Save as: lua/plugins/surround.lua

return {
    {
        "kylechui/nvim-surround",
        version = "*",     -- Use latest stable release
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Default config, customize if needed
                keymaps = {
                    -- Normal mode
                    insert = "<C-g>s",
                    insert_line = "<C-g>S",
                    normal = "ys",
                    normal_cur = "yss",
                    normal_line = "yS",
                    normal_cur_line = "ySS",

                    -- Visual mode
                    visual = "S",
                    visual_line = "gS",

                    -- Delete/change
                    delete = "ds",
                    change = "cs",
                    change_line = "cS",
                },
            })
        end,
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
