  return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {"help", "rust", "lua", "vim", "query", "c", "markdown", "python", "java", "html", "css", "javascript" },
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end
    configs.setup(opts)
  end,
}     
