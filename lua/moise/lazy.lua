local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- categorías de plugins: cada una es un módulo que devuelve specs
  spec = {
    { import = "moise.plugins.extras" },
    { import = "moise.plugins.ui" },
    -- pendientes de crear:
    -- { import = "moise.plugins.ui" },
    { import = "moise.plugins.git" },
    { import = "moise.plugins.syntax" },
    { import = "moise.plugins.cmp" },
    { import = "moise.plugins.lsp" },
    -- pendientes:
  },
  default = {
    lazy = true,
    version = false
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
