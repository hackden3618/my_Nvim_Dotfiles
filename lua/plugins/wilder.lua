-- ==========================================
-- WILDER.LUA - Better command-line completion
-- ==========================================
-- Save as: lua/plugins/wilder.lua (separate file)

-- NOTE: Create this as a SEPARATE file: lua/plugins/wilder.lua
return {
    {
        "gelguy/wilder.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local wilder = require("wilder")

            wilder.setup({
                modes = { ":", "/", "?" },
            })

            -- Style configuration
            wilder.set_option("renderer", wilder.popupmenu_renderer(
                wilder.popupmenu_border_theme({
                    highlights = {
                        border = "Normal",
                        accent = wilder.make_hl("WilderAccent", "Pmenu",
                            { { a = 1 }, { a = 1 }, { foreground = "#5ea1ff" } }),
                    },
                    border = "rounded",
                    max_height = "20%",
                    min_height = "20%",
                    max_width = "50%",
                    left = { " ", wilder.popupmenu_devicons() },
                    right = { " ", wilder.popupmenu_scrollbar() },
                    pumblend = 20,
                })
            ))

            -- Enable fuzzy matching
            wilder.set_option("pipeline", {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        fuzzy = 1,
                        fuzzy_filter = wilder.vim_fuzzy_filter(),
                    }),
                    wilder.vim_search_pipeline()
                ),
            })
        end,
    },
}
