return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require "mason"

    local mason_lspconfig = require "mason-lspconfig"

    local mason_tool_installer = require "mason-tool-installer"

    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        "ts_ls",
        "gopls",
        "lua_ls",
        "pyright",
        "terraformls",
        "dockerls",
        "jsonls",
        "yamlls",
        "bashls",
        "docker_compose_language_service",
      },
      -- eslint-lsp NO se auto-habilita: eslint lo maneja none-ls (source de
      -- extras, gated por config). Este setup corre PRIMERO (mason se carga
      -- antes que lspconfig), así que sin esto eslint-lsp se habilita y
      -- duplica los diagnósticos.
      automatic_enable = { exclude = { "eslint" } },
    }

    mason_tool_installer.setup {
      -- [[
      -- TODO:
      --# Formatters
      --    - prettier ( JS )
      --    - stylua ( lua )
      --    - black ( python )
      --# Linter
      --    - pylint ( python )
      --    - eslint ( JS )
      --    - golangci-lint ( GO )
      --]]
      ensure_installed = {
        -- Lua
        "stylua",

        -- Go
        "golangci-lint",

        -- Python
        "black",
        "pylint",

        -- JavaScript / TypeScript
        "prettier",
        "eslint",

        -- YAML
        "yamllint",

        -- Terraform
        "tflint",

      },
    }
  end,
}
