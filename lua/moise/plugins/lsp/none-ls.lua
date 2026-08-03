-- none-ls (fork de null-ls): linting + formatting en un solo plugin, con
-- resultados como diagnósticos LSP nativos. Reemplaza a conform.nvim y
-- nvim-lint.
--
-- "Respetar el repo": cada source corre solo si existen los archivos de
-- config en la raíz del proyecto (utils.n — nativo de none-ls, nada que
-- reinventar).
return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim", -- sources extra (eslint, etc.)
  },
  config = function()
    local none_ls = require "null-ls"
    local command_resolver = require("null-ls.helpers.command_resolver")

    local sources = {
      -- Formateo
      none_ls.builtins.formatting.prettier.with {
        prefer_local = "node_modules/.bin",
        -- preferir el binario local del proyecto (node_modules/.bin), fallback al global
        --dynamic_command = command_resolver.from_node_modules(),
        condition = function(utils)
          return utils.root_has_file(
            ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml",
            ".prettierrc.js", ".prettierrc.cjs", "prettier.config.js", "prettier.config.cjs",
            ".editorconfig"
          )
        end,
      },
      none_ls.builtins.formatting.stylua.with {
        condition = function(utils)
          return utils.root_has_file("stylua.toml", ".stylua.toml")
        end,
      },
      none_ls.builtins.formatting.black.with {
        condition = function(utils)
          return utils.root_has_file("pyproject.toml", "setup.cfg")
        end,
      },
      none_ls.builtins.formatting.gofmt.with {
        condition = function(utils)
          return utils.root_has_file("go.mod")
        end,
      },
      none_ls.builtins.formatting.goimports.with {
        condition = function(utils)
          return utils.root_has_file("go.mod")
        end,
      },
      -- Diagnóstico
      none_ls.builtins.diagnostics.pylint.with {
        condition = function(utils)
          return utils.root_has_file("pyproject.toml", "setup.cfg", ".pylintrc", "Pipfile")
        end,
      },
      none_ls.builtins.diagnostics.golangci_lint.with {
        condition = function(utils)
          return utils.root_has_file(".golangci.yml", ".golangci.yaml")
        end,
      },
      -- eslint (source de none-ls-extras): solo si el repo tiene config
      require("none-ls.diagnostics.eslint").with {
        prefer_local = "node_modules/.bin",
        -- preferir el binario local del proyecto (node_modules/.bin), fallback al global
        --dynamic_command = command_resolver.from_node_modules(),
        condition = function(utils)
          return utils.root_has_file(
            ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml",
            ".eslintrc.json", "eslint.config.js", "eslint.config.cjs", "eslint.config.mjs"
          )
        end,
      },
    }

    none_ls.setup { sources = sources }

    -- Formateo al guardar: solo el cliente none-ls, no el LSP del lenguaje
    local format_augroup = vim.api.nvim_create_augroup("NoneLsFormat", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = format_augroup,
      callback = function(args)
        vim.lsp.buf.format {
          bufnr = args.buf,
          filter = function(client)
            return client.name == "null-ls"
          end,
        }
      end,
    })

    -- Manual: formatear con none-ls (el usuario lo pide explícito)
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      vim.lsp.buf.format {
        filter = function(client)
          return client.name == "null-ls"
        end,
      }
    end, { desc = "Format file or range (none-ls)" })
  end,
}
