-- Lualine: statusline. Vuelve como plugin propio porque snacks.statusline
-- no existe en la versión instalada de snacks.nvim (se ignora en silencio).
-- Replica las secciones de la config vieja (lualine con theme rxyhn),
-- ahora con el theme builtin "codedark" elegido por el usuario.
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "codedark",
      globalstatus = true
    },
    sections = {
      lualine_a = { { "mode", upper = true } },
      lualine_b = { "diff", { "branch", icon = "" } },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { { "diagnostics" }, "filetype" },
      lualine_y = { "lineinfo", "progress" },
      lualine_z = { "location" },
    },
  },
}
