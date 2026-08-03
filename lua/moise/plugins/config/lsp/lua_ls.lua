local M = {}

function M.setup(lspconfig, capabilities)
          require("neodev").setup()
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  enable = true,
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
                workspace = {
                  library = {
                    [vim.fn.expand "VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                  },
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          }
        end

        return M;