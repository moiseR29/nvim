return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"
    local repo_config = require "moise.utils.repo_config"

    lint.linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      python = { "pylint" },
      go = { "golangcilint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Lint automático SOLO si el repo tiene config de esa tool (ej. .eslintrc).
    -- Respetar el repo: no romper repos que no configuraron linters.
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function(args)
        if repo_config.has_repo_config(vim.bo[args.buf].filetype) then
          lint.try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>tl", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
