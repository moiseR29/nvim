local M = {}

function M.setup(lspconfig, capabilities)
          lspconfig.gopls.setup {
            capabilities = capabilities,
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                --gofumpt = true,
                usePlaceholders = true,
                analyses = {
                  nilness = true,
                  shadow = true,
                  unusedparams = true,
                  unusedwrites = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            },
          }
end