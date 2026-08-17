local u = require "moise.utils"

local options = {
  -- no mostrar el modo actual (INSERT/NORMAL) en la barra inferior
  -- depende: si no tenés statusline (p.ej. lualine), no vas a ver en qué modo estás
  showmode = false,

  -- mostrar el nombre del archivo en el título de la ventana del terminal
  -- depende: que el emulador de terminal soporte títulos
  title = true,

  -- compartir el registro '+' con el clipboard del sistema (copiar/pegar fuera de nvim)
  -- depende: de un provider en el sistema: xclip/wl-clipboard (Linux), pbcopy (macOS)
  clipboard = "unnamedplus",

  -- insertar espacios en lugar de un carácter tab al presionar <Tab>
  -- depende: softtabstop/shiftwidth (cuántos espacios), tabstop (ancho visual de tabs ya existentes)
  expandtab = true,

  -- espacios por nivel de indentación (comandos >> <<, y autoindent)
  -- con expandtab = true, toda indentación nueva son espacios y shiftwidth manda
  shiftwidth = 2,

  -- al presionar <Enter>, copia la indentación de la línea anterior
  autoindent = true,

  -- ignora mayúsculas/minúsculas en los patrones de búsqueda (/ y *)
  -- complementa: si activás smartcase, respeta el case cuando el patrón contiene mayúsculas
  ignorecase = true,

  -- respeta mayúsculas si el patrón las tiene (requiere ignorecase)
  smartcase = true,

  -- habilita el mouse en todos los modos (a = all)
  mouse = "a",

  -- mostrar el número de línea absoluto
  number = true,

  -- ancho mínimo de la columna de números
  -- si es menor que los dígitos reales, la columna crece y el texto salta (jitter)
  numberwidth = 4,

  -- ancho visual de un carácter tab (solo afecta tabs ya existentes en el archivo)
  tabstop = 2,

  -- habilita colores de 24 bits
  -- depende: que el terminal soporte truecolor y que el colorscheme los use
  termguicolors = true,

  -- números relativos a la línea del cursor (0 = línea actual)
  -- combinado con number: la línea del cursor muestra el absoluto, el resto relativo
  relativenumber = true,

  -- si la línea es más larga que la pantalla, la continúa en la siguiente línea visual
  -- (si es false, lo que no entra queda cortado)
  wrap = true,

  -- no crear archivos swap en disco
  swapfile = false,

  -- codificación con la que se guarda el archivo
  fileencoding = "utf-8",

  -- codificación interna del buffer: nvim es siempre UTF-8, no hace falta setearla
  encoding = "utf-8",

  -- resaltar la línea donde está el cursor
  cursorline = true,

  -- cuántos espacios inserta/borra <Tab>/<Backspace> en modo insert
  -- con expandtab, define el ancho del tab insertado
  softtabstop = 2,

  -- al inicio de la línea, <Tab> usa shiftwidth en vez de softtabstop/tabstop
  smarttab = true,

  -- los splits verticales nuevos se abren a la derecha (el archivo actual
  -- queda a la izquierda). Lo usa snacks (<C-v> en el explorer/pickers) y :vsplit
  splitright = true,

  -- ms que espera una secuencia de teclas incompleta (p.ej. <leader> + prefijo)
  timeoutlen = 400,

  -- ms entre ticks: gatilla CursorHold, autosave, etc.
  updatetime = 250,

  -- menú de autocompletado (<C-n>/<C-p>)
  -- menuone: mostrar el menú aunque haya una sola opción
  -- noselect: no seleccionar el primer ítem, solo resaltarlo (Enter inserta la opción)
  completeopt = { "menuone", "noselect" },
}

for k, v in pairs(options) do
  u.addOpt(k, v)
end
