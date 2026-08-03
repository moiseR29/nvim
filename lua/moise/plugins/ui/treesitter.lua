-- Treesitter: instalación y gestión de parsers.
--
-- IMPORTANTE (nvim 0.12 + nvim-treesitter rewrite 2025):
-- * El highlight ya lo hace nvim de forma nativa (vim.treesitter), ya no se
--   configura acá. La API vieja (configs.setup + ensure_installed) fue removida.
-- * Acá solo se instalan los parsers de forma explícita.
-- * La indentación por treesitter es experimental (vim.bo.indentexpr); por
--   ahora queda el autoindent clásico de vim.
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install {
      "bash",
      "go",
      "gomod",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "sql",
      "typescript",
      "regex",
      "vim",
      "yaml",
      "dockerfile",
      "python",
      "hcl",
    }
  end,
}
