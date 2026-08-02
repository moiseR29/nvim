local u = require "moise.utils"

-- <Space>: liberar la tecla para usarla como leader (modos normal/visual/select/op-pending)
u.keymap("", "<Space>", "<Nop>")

-- <leader> = <Space>: variable que reemplaza <leader> en todos los keymaps de abajo
u.global("mapleader", " ")
u.global("maplocalleader", " ")

-- <F5>: re-ejecuta init.lua
-- (nota: no recarga los módulos lua, quedan cacheados en package.loaded —
--  para recargar cambios de keymaps/options hay que reiniciar nvim)
u.keymap("n", "<F5>", ":source ~/.config/nvim/init.lua<CR>")
u.keymap("v", "<F5>", ":source ~/.config/nvim/init.lua<CR>")

-- flechas: deshabilitar la navegación con flechas (forzar hjkl)
-- en modo normal se re-mapean más abajo para resize de ventanas
u.keymap("", "<up>", "<Nop>")
u.keymap("", "<down>", "<Nop>")
u.keymap("", "<left>", "<Nop>")
u.keymap("", "<right>", "<Nop>")

-- <leader>sr: split vertical — parte la pantalla en dos, izquierda/derecha
u.keymap("n", "<leader>sr", ":vs<CR>")
-- <leader>sb: split horizontal — parte la pantalla en dos, arriba/abajo
u.keymap("n", "<leader>sb", ":sp<CR>")

-- <left>: aumenta el ancho de la ventana actual en 3 columnas
u.keymap("n", "<left>", ":vertical resize +3<CR>")
-- <right>: disminuye el ancho de la ventana actual en 3 columnas
u.keymap("n", "<right>", ":vertical resize -3<CR>")
-- <down>: disminuye el alto de la ventana actual en 3 líneas
u.keymap("n", "<down>", ":resize -3<CR>")
-- <up>: aumenta el alto de la ventana actual en 3 líneas
u.keymap("n", "<up>", ":resize +3<CR>")

-- <leader>bn: abre un tab nuevo con un buffer vacío
-- (ojo: es un TAB, no un buffer nuevo — si querés buffer, sería :enew)
u.keymap("n", "<leader>bn", ":tabe<CR>")

-- <leader>bw: cierra el buffer actual (forzado, descarta cambios sin guardar)
u.keymap("n", "<leader>bw", ":bdelete!<CR>")

-- <leader>h: tab anterior
-- <leader>l: tab siguiente
-- (son TABS, no buffers — :tabn/:tabp navegan tabpages)
u.keymap("n", "<leader>l", ":tabn<CR>")
u.keymap("n", "<leader>h", ":tabp<CR>")

-- <leader>w: guarda el archivo actual
u.keymap("n", "<leader>w", ":w<CR>")

-- <A-j>/<A-k> en normal: mover la línea actual hacia abajo/arriba
u.keymap("n", "<A-j>", ":m .+1<CR>==")
u.keymap("n", "<A-k>", ":m .-2<CR>==")
-- <A-j>/<A-k> en insert: mueve la línea y vuelve a modo insert en la misma posición
u.keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
u.keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
-- <A-j>/<A-k> en visual: mueve solo las líneas seleccionadas y conserva la selección
u.keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
u.keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- (dead code, pendiente de decidir: cerrar/guardar y salir)
--u.keymap("n", "<leader>qq", ":q!<CR>")
--u.keymap("n", "<leader>wq", ":wq!<CR>")

-- (dead code, terminal: pendiente de decidir)
--u.keymap("t", "<Esc><Esc>", "<C-\\><C-n>")
--u.keymap("n", "<leader>t", ":belowright terminal<CR>")
