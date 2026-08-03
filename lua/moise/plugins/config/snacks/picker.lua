return {
  enabled = true,
  ui_select = true,
  -- El explorer es un picker en esta versión de snacks: las opciones del
  -- explorer se configuran como source del picker (no bajo opts.explorer).
  -- El layout se pasa por keymap (ver keys.lua): sidebar o vertical.
  sources = {
    explorer = {
      follow_file = true, -- sigue el archivo del buffer actual (update_focused_file de nvim-tree)
      git_status = true, -- iconos de git (git.enable = true de nvim-tree)
      git_untracked = true, -- mostrar archivos untracked
    },
  },
}
