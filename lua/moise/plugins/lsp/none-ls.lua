-- none-ls (fork de null-ls): linting + formatting en un solo plugin, con
-- resultados como diagnósticos LSP nativos. Reemplaza a conform.nvim y
-- nvim-lint.
--
-- "Respetar el repo": cada source corre solo si existen los archivos de
-- config en la raíz del proyecto (utils.n — nativo de none-ls, nada que
-- reinventar).
return {
  "nvimtools/none-ls.nvim",
  -- BufReadPre/BufNewFile: cargar ANTES de que el buffer dispare FileType,
  -- así el autocmd interno de none-ls (try_add) agarra el buffer al vuelo.
  -- VeryLazy dependía del primer idle: guardar antes = "no matching language servers".
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim", -- sources extra (eslint, etc.)
  },
  config = function()
    local none_ls = require "null-ls"
    local command_resolver = require("null-ls.helpers.command_resolver")

    -- Buscar un archivo de config subiendo desde el directorio del buffer,
    -- tal como prettier/eslint resuelven SU config. root_has_file de none-ls
    -- mira SOLO el root del proyecto (root_pattern .git): en un monorepo ese
    -- root es el del repo raíz y la condición falla si la config vive en un
    -- package/subdirectorio (ej: api/.prettierrc con el repo en reberp/).
    local function find_up(...)
      local names = { ... }
      local fname = vim.api.nvim_buf_get_name(0)
      if fname == "" then
        return false
      end
      local dir = vim.fn.fnamemodify(fname, ":p:h")
      while true do
        for _, name in ipairs(names) do
          if vim.fn.filereadable(dir .. "/" .. name) == 1 then
            return true
          end
        end
        local parent = vim.fn.fnamemodify(dir, ":h")
        if parent == dir then
          return false
        end
        dir = parent
      end
    end

    local sources = {
      -- Formateo
      none_ls.builtins.formatting.prettier.with {
        --prefer_local = "node_modules/.bin",
        -- preferir el binario local del proyecto (node_modules/.bin), fallback al global
        dynamic_command = command_resolver.from_node_modules(),
        condition = function()
          -- TODOS los nombres válidos de config de prettier (v2 y v3), buscados
          -- hacia arriba desde el buffer (monorepo-safe).
          return find_up(
            ".prettierrc", ".prettierrc.json", ".prettierrc.json5", ".prettierrc.yml",
            ".prettierrc.yaml", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.mjs",
            ".prettierrc.toml", "prettier.config.js", "prettier.config.cjs",
            "prettier.config.mjs", "prettier.config.mts", "prettier.config.ts",
            "package.json", ".editorconfig"
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
      --require("none-ls.diagnostics.eslint").with {
      --  --prefer_local = "node_modules/.bin",
      --  -- preferir el binario local del proyecto (node_modules/.bin), fallback al global
      --  dynamic_command = command_resolver.from_node_modules(),
      --  condition = function()
      --    -- flat config moderna (js/cjs/mjs/ts/mts) + legacy (.eslintrc*),
      --    -- buscados hacia arriba desde el buffer (monorepo-safe).
      --    return find_up(
      --      ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.mjs",
      --      ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
      --      "eslint.config.js", "eslint.config.cjs", "eslint.config.mjs",
      --      "eslint.config.ts", "eslint.config.mts"
      --    )
      --  end,
      --},
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
