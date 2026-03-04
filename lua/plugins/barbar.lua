return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function() vim.g.barbar_auto_setup = 0 end, -- recommended for performance
  opts = {
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    icons = {
      buffer_index = true,
      filetype = { enabled = true },
      button = '×',
      -- New structure for diagnostics
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
      },
    },
  },
  config = function(_, opts)
    require("barbar").setup(opts)
    local map = vim.keymap.set
    local map_opts = { noremap = true, silent = true }

    -- Navigation
    map("n", "<leader>bh", "<Cmd>BufferPrevious<CR>", map_opts)
    map("n", "<leader>bl", "<Cmd>BufferNext<CR>", map_opts)

    -- Jump to buffer 1-9
    for i = 1, 9 do
      map("n", "<leader>b" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", map_opts)
    end
    map("n", "<leader>b0", "<Cmd>BufferLast<CR>", map_opts)

    -- Actions
    map("n", "<leader>bc", "<Cmd>BufferClose<CR>", map_opts)
    map("n", "<leader>bb", "<Cmd>BufferPick<CR>", map_opts)
    map("n", "<leader>bd", "<Cmd>BufferPickDelete<CR>", map_opts)
  end,
}
