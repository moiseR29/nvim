local M = {}

function M.setup(lspconfig, capabilities)
          lspconfig["yamlls"].setup {
            capabilities = capabilities,
            settings = {
              yaml = {
                schemas = {
                    ["https://kubernetesjsonschema.dev/v1.10.3-standalone/service-v1.json"] = "*service.yaml",
                    ["https://kubernetesjsonschema.dev/v1.14.0/deployment-app-v1.json"] = "*deployment.yaml",
                    -- AWS SAM (template.yaml) — schema oficial de AWS (catálogo schemastore)
                    ["https://raw.githubusercontent.com/aws/serverless-application-model/main/samtranslator/schema/schema.json"] = "template.{yaml,yml}",
                    -- CloudFormation — goformation (URL del catálogo schemastore)
                    ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "cloudformation.{yaml,yml}",
                    -- Swagger 2.0 — schema oficial OAS 2.0 (catálogo schemastore)
                    ["https://spec.openapis.org/oas/2.0/schema/2017-08-27"] = "swagger.{yaml,yml}",
                    -- Serverless framework (catálogo schemastore)
                    ["https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json"] = "serverless.{yaml,yml}",
                },
              },
            },
          }
end

return M