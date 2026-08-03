return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  -- nvim-cmp NO se declara como dependency a propósito: la integración
  -- (cmp_autopairs.on_confirm_done) se hace con pcall dentro del config,
  -- así que autopairs anda solo. Cuando se arme la categoría cmp, se
  -- vuelve a declarar o se hace el require explícito desde el spec de cmp.
  config = function ()
    local present, autopairs = pcall(require, "nvim-autopairs")
    local secondPresent, cmp = pcall(require, "cmp")

    if not present then
      return
    end

    local options = {
      fast_wrap = { },
      check_ts = true,
      ts_config = {
        lua = {"string"},
        javascript = {"template_string"}
      },
      disable_filetype = { "vim" }  -- quitado "TelescopePromp" (typo + legacy; ahora es snacks)
    }

    autopairs.setup(options)

    if secondPresent then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end

  end
}