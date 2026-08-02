-- Categoría "extras": plugins que no encajan en las otras categorías.
-- Cada sub-módulo devuelve la spec de un plugin.
return {
  { import = "moise.plugins.extras.plenary" },
  { import = "moise.plugins.extras.tmux-navigator" },
  { import = "moise.plugins.extras.visual-multi" },
}
