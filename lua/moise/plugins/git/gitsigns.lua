return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
    },
    -- rendimiento - antes true
    current_line_blame = false,
    on_attach = function (bufnr)
      local gitsigns = require("gitsigns")
      vim.keymap.set("n", "<leader>gsp", gitsigns.preview_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>gsn", gitsigns.next_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>gsr", gitsigns.reset_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>gsu", gitsigns.undo_stage_hunk, { buffer = bufnr })
      --u.keymap("n", "<leader>gsf", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
      --u.keymap("n", "<leader>gsft", "<cmd>Gitsigns diffthis<CR>")
    end,
    max_file_length = 10000,
  },
}