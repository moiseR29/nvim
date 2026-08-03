return {
  "Mofiqul/vscode.nvim",
  lazy = false, -- los colorschemes se cargan al arranque
  priority = 1000,
  config = function()
    local vscode = require("vscode")
    vscode.setup({
      style = "dark",
      transparent = true,
      disable_nvimtree_bg = true,
    })
    vscode.load()
  end,
}
