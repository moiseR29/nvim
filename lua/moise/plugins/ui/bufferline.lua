-- Bufferline: muestra los buffers como pestañas arriba de la pantalla.
-- Complementa a lualine (statusline abajo) y al picker de buffers de snacks
-- (<leader>,). Necesita nvim-web-devicons para los iconos de tipo de archivo.
return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false, -- tiene que estar listo al arranque (la tabline se ve siempre)
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        show_buffer_default_name = true,
        -- no cierra buffers al saltar entre ellos (default true es molesto)
        close_on_jump = false,
        separator_style = "slant",
        always_show_bufferline = true,
        offsets = {
          filetype = "snacks_picker_list",
          text = "Explorer",
          highlight = "Directory",
          separator = true
        }
      },
    })
  end,
  -- <Tab>/<S-Tab> ciclan entre buffers. Dentro de un picker de snacks
  -- (explorer, find files, etc.) los keymaps del picker son buffer-local
  -- y pisan a estos, así que ahí siguen navegando entradas sin conflicto.
  keys = {
    { "<Tab>", function() vim.cmd("BufferLineCycleNext") end, mode = "n", desc = "Next buffer" },
    { "<S-Tab>", function() vim.cmd("BufferLineCyclePrev") end, mode = "n", desc = "Previous buffer" },
    --{ "<C-1>", function() vim.cmd("BufferLineGoToBuffer 1") end, mode = "n", desc = "Go to buffer 1" },
    --{ "<C-2>", function() vim.cmd("BufferLineGoToBuffer 2") end, mode = "n", desc = "Go to buffer 2" },
    --{ "<C-3>", function() vim.cmd("BufferLineGoToBuffer 3") end, mode = "n", desc = "Go to buffer 3" },
    --{ "<C-4>", function() vim.cmd("BufferLineGoToBuffer 4") end, mode = "n", desc = "Go to buffer 4" },
    --{ "<C-5>", function() vim.cmd("BufferLineGoToBuffer 5") end, mode = "n", desc = "Go to buffer 5" },
  },
}
