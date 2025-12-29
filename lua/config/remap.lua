vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex )

-- remap escape key
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("v", "jk", "<Esc>")

--keymap for window navigation
vim.keymap.set("n","<leader>wv",":vsplit<cr>")
vim.keymap.set("n","<leader>wh",":split<cr>")

vim.keymap.set("n","<leader>wh","<C-w><C-h>", { desc = "Move focus to left window"})
vim.keymap.set("n","<leader>wl","<C-w><C-l>", { desc = "Move focus to right window"})
vim.keymap.set("n","<leader>wj","<C-w><C-j>", { desc = "Move focus to bottom window"})
vim.keymap.set("n","<leader>wk","<C-w><C-k>", { desc = "Move focus to top window"})

--keymap for escaping the search highlight
vim.keymap.set("n","<Esc>","<cmd>nohlsearch<cr>", { desc = "Escape search highlight"})

-- remapping the terminal opening
vim.keymap.set("n","<leader>tO","<cmd>terminal<cr>", { desc = "Open terminal here"})
