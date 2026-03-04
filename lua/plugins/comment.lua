-- =============================================================================
-- COMMENT.LUA - Smart commenting (supports JSX/TSX context)
-- =============================================================================

return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring", -- correct comment style in mixed files
        },

        config = function()
            local comment                  = require("Comment")
            local ts_context_comment_string = require("ts_context_commentstring.integrations.comment_nvim")

            comment.setup({
                pre_hook = ts_context_comment_string.create_pre_hook(),
            })

            -- Toggle comment on current line (normal mode)
            vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
            -- Toggle comment on selection (visual mode)
            vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  { desc = "Comment Selected" })
        end,
    },
}
