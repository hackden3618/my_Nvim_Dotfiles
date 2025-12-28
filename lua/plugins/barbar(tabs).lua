return {
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",       -- git status in tabs
      "nvim-tree/nvim-web-devicons",   -- file icons
    },

    -- Lazy.nvim will call setup() automatically
    opts = {
      animation = true,
      auto_hide = false,
      tabpages = true,
      clickable = true,

      icons = {
        buffer_index = true,
        buffer_number = false,
        button = "",
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true },
          [vim.diagnostic.severity.WARN]  = { enabled = true },
          [vim.diagnostic.severity.INFO]  = { enabled = false },
          [vim.diagnostic.severity.HINT]  = { enabled = false },
        },
      },
    },

    config = function(_, opts)
      require("barbar").setup(opts)

      local map = vim.keymap.set
      local opts_map = { noremap = true, silent = true }

      -- =====================
      -- Buffer navigation
      -- =====================
      map("n", "<leader>bp", "<Cmd>BufferPrevious<CR>", opts_map)
      map("n", "<leader>bn", "<Cmd>BufferNext<CR>", opts_map)

      -- Jump to buffer by position
      for i = 1, 9 do
        map("n", "<leader>b" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", opts_map)
      end
      map("n", "<leader>b0", "<Cmd>BufferLast<CR>", opts_map)

      -- =====================
      -- Reordering buffers
      -- =====================
      map("n", "<leader>b<", "<Cmd>BufferMovePrevious<CR>", opts_map)
      map("n", "<leader>b>", "<Cmd>BufferMoveNext<CR>", opts_map)

      -- =====================
      -- Buffer actions
      -- =====================
      map("n", "<leader>bc", "<Cmd>BufferClose<CR>", opts_map)
      map("n", "<leader>bp", "<Cmd>BufferPin<CR>", opts_map)

      -- Pick a buffer interactively
      map("n", "<leader>bb", "<Cmd>BufferPick<CR>", opts_map)
      map("n", "<leader>bd", "<Cmd>BufferPickDelete<CR>", opts_map)

      -- =====================
      -- Sorting
      -- =====================
      map("n", "<leader>bsn", "<Cmd>BufferOrderByBufferNumber<CR>", opts_map)
      map("n", "<leader>bsf", "<Cmd>BufferOrderByName<CR>", opts_map)
      map("n", "<leader>bsd", "<Cmd>BufferOrderByDirectory<CR>", opts_map)
      map("n", "<leader>bsl", "<Cmd>BufferOrderByLanguage<CR>", opts_map)
      map("n", "<leader>bsw", "<Cmd>BufferOrderByWindowNumber<CR>", opts_map)
    end,
  },
}
