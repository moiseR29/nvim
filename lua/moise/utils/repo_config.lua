-- Detecta si el repo del buffer actual tiene config de lint/format para su
-- filetype. Idea: NO correr linters/formatters automáticos en repos que no
-- configuraron esa tool (respetar el repo, evitar diffs no deseados).
-- La búsqueda sube directorios desde el cwd (cubre el repo root).

local M = {}

-- Patrones de archivos de config por filetype.
-- Si existe ALGUNO de estos en el repo, se considera que el repo configuró
-- la tool y se puede correr lint/format automático.
local config_files = {
  javascript = {
    ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
    "eslint.config.js", "eslint.config.cjs", "eslint.config.mjs",
    ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.js", ".prettierrc.cjs",
    "prettier.config.js", "prettier.config.cjs", ".editorconfig",
  },
  typescript = {
    ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
    "eslint.config.js", "eslint.config.cjs", "eslint.config.mjs",
    ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.js", ".prettierrc.cjs",
    "prettier.config.js", "prettier.config.cjs", ".editorconfig",
    "tsconfig.json",
  },
  json = { ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".editorconfig" },
  yaml = { ".prettierrc", ".prettierrc.yml", ".prettierrc.yaml", ".yamllint", ".yamllint.yaml", ".yamllint.yml" },
  lua = { "stylua.toml", ".stylua.toml" },
  python = { "pyproject.toml", "setup.cfg", ".pylintrc", "Pipfile", "pyrightconfig.json" },
  go = { "go.mod", ".golangci.yml", ".golangci.yaml" },
}

local function has_any(patterns)
  for _, p in ipairs(patterns) do
    -- ".;" busca en el cwd y subiendo hasta la raíz (ver :h findfile)
    if vim.fn.findfile(p, ".;") ~= "" then
      return true
    end
  end
  return false
end

---@param ft string
---@return boolean true si el repo configura lint/format para ese filetype
function M.has_repo_config(ft)
  local patterns = config_files[ft]
  if not patterns then
    return false
  end
  return has_any(patterns)
end

return M
