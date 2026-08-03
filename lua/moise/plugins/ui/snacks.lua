-- Snacks: reemplaza alpha (dashboard), nvim-tree (explorer), indent-blankline
-- (indent), dressing (input/select) y telescope (picker + keymaps).
-- Nota: la terminal vuelve a toggleterm (ver ui/toggleterm.lua) y la
-- statusline a lualine.
--
-- Nota: todo vive en ESTE archivo. Los módulos no se separan en archivos
-- porque lazy.nvim, al importar un directorio, trata cada archivo como un
-- spec de plugin (y una lista de keymaps suelta se interpreta como specs).
return {
  "folke/snacks.nvim",
  priority = 1000, -- se carga temprano (necesita autocmds antes que otros plugins)
  lazy = false, -- los keymaps de snacks deben existir desde el arranque
  opts = {
    -- Dashboard: pantalla de inicio (reemplaza alpha.nvim).
    -- El header ASCII y los botones vienen de la config vieja de alpha.
    dashboard = require("moise.plugins.config.snacks.dashboard"),
    -- Explorer: reemplaza nvim-tree y el file_browser de telescope.
    -- Replica el comportamiento de la config vieja de nvim-tree:
    -- filtros, git, panel izquierdo, seguir el archivo del buffer.
    explorer = require("moise.plugins.config.snacks.explorer"),
    -- Indent: guías de indentación (reemplaza indent-blankline).
    indent = require("moise.plugins.config.snacks.indent"),
    -- Input: reemplaza vim.ui.input (lo que hacía dressing para los prompts).
    input = require("moise.plugins.config.snacks.input"),
    -- Notifier: reemplaza los mensajes de vim por notificaciones.
    notifier = require("moise.plugins.config.snacks.notifier"),
    -- Picker: reemplaza telescope y dressing.
    -- ui_select = true reemplaza vim.ui.select (lo que hacía telescope-ui-select).
    picker = require("moise.plugins.config.snacks.picker"),
  },
  -- Keymaps de snacks: preset del picker (reemplaza los keymaps de telescope).
  -- <C-p> y <C-f> se conservan de la config vieja de telescope.
  keys = require("moise.plugins.config.snacks.keys"),
}
