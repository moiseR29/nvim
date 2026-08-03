return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git" },
  keys = {
    { "<leader>fgl", "<cmd> diffget //3<CR>", desc = "Git: diffget from //3" },
    { "<leader>fgr", "<cmd> diffget //2<CR>", desc = "Git: diffget from //2" },
    { "<leader>fgs", "<cmd> G<CR>", desc = "Git: status" }
  }
}