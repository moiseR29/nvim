return {
  "folke/todo-comments.nvim",
  keys = {
    { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todos"},
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
    todo_comments.setup()
  end,
}
