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
        "terraform_fmt",
        "tflint",

      },
    }
  end,
}
