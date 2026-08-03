-- Toggleterm: vuelve a ser el plugin de terminales (reemplaza al snacks.terminal
-- que estaba dando problemas con la identidad cmd+cwd).
return {
  "akinsho/toggleterm.nvim",
  version = "*",

  config = function()
    local u = require "moise.utils"
    local terminal = require "toggleterm"

    -- <esc> en modo terminal: sale a modo normal al toque.
    -- Equivale al <C-\><C-n> nativo, pero mapeado explícito para que sea
    -- instantáneo (sin esperar doble ESC).
    u.keymap("t", "<esc>", [[<C-\><C-n>]])
    -- Segunda terminal independiente (2ToggleTerm).
    u.keymap("n", "<leader>tt", ":2ToggleTerm<CR>")

    terminal.setup({
      open_mapping = [[<c-t>]],
    })
  end,
}
