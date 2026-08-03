local M = {}

function M.setup(lspconfig, capabilities)
          lspconfig.terraformls.setup {
            capabilities = capabilities,
            cmd = { "terraform-ls", "serve" },
            filetypes = { "tf" },
          }
end

return M