return {
  "stevearc/conform.nvim",
  -- rendimiento
  --event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",
  config = function()
    local conform = require "conform"
    local repo_config = require "moise.utils.repo_config"

    -- Formatters por filetype. Respeto al repo: si no hay archivo de config
    -- (ej. .prettierrc, stylua.toml, pyproject.toml...), NO se formatea.
    -- Así no se rompen repos que no configuraron formateo.
    local formatters = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      -- markdown = { "prettier" },
      lua = { "stylua" },
      python = { "black" },
      go = { "goimports", "gofmt" },
    }

    conform.setup {
      formatters_by_ft = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if not repo_config.has_repo_config(ft) then
          return {} -- el repo no configuró formateo → no tocar
        end
        return formatters[ft] or {}
      end,
      format_on_save = {
        -- lsp_fallback = false: sin config en el repo no se formatea ni
        -- con el LSP (respetar el repo, "si no no")
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      },
    }

    -- Manual: formatea con fallback a LSP (el usuario lo pide explícito)
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
