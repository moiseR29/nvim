local M = {}

function M.setup(lspconfig, capabilities)
          lspconfig.jsonls.setup {
            capabilities = capabilities,
            settings = {
              json = {
                schemas = {
                  {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json",
                  },
                  {
                    fileMatch = { "tsconfig*.json" },
                    url = "https://json.schemastore.org/tsconfig.json",
                  },
                  {
                    fileMatch = { ".prettierrc", ".prettierrc.json", ".prettierrc.config.json" },
                    url = "https://json.schemastore.org/prettierrc.json",
                  },
                  {
                    fileMatch = { ".eslintrc", ".eslintrc.json" },
                    url = "https://json.schemastore.org/eslintrc.json",
                  },
                },
              },
            },
          }
  
end

return M