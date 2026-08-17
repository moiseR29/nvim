-- Categoría "ui": interfaz visual del editor.
-- snacks.nvim es el plugin principal: reemplaza alpha, dressing e indent-blankline
-- de la config vieja. Lualine y toggleterm vuelven como plugins propios
-- (snacks.statusline no existe; snacks.terminal daba problemas con la
-- identidad cmd+cwd de las terminales).
return {
  { import = "moise.plugins.ui.snacks" },
  { import = "moise.plugins.ui.lualine" },
  { import = "moise.plugins.ui.toggleterm" },
  { import = "moise.plugins.ui.bufferline" },
  { import = "moise.plugins.ui.colorscheme" },
  { import = "moise.plugins.ui.treesitter" },
  { import = "moise.plugins.ui.trouble" },
  { import = "moise.plugins.ui.render-markdown" },
}
