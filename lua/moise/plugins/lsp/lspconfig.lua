return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
    { "ray-x/lsp_signature.nvim", event = "InsertEnter" },
  },
  config = function()
    local lspconfig = require "lspconfig"

    local mason_lspconfig = require "mason-lspconfig"

    local cmp_nvim_lsp = require "cmp_nvim_lsp"

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Go to definition"
        keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
        opts.desc = "LSP code actions"
        keymap.set({"n", "v"}, "<leader>vca", vim.lsp.buf.code_action, opts)

        -- keymap.set("n", "<leader>vn", ':lua vim.lsp.diagnostic.goto_next({ border = "rounded" })<cr>')
        -- keymap.set("n", "<leader>vp", ':lua vim.lsp.diagnostic.goto_prev({ border = "rounded" })<cr>')
        keymap.set("n", "<leader>vn", ':lua vim.diagnostic.goto_next({ border = "rounded" })<cr>')
        keymap.set("n", "<leader>vp", ':lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>')

        keymap.set("n", "<leader>vf", ":lua vim.lsp.buf.format()<cr>")

        --u.buf_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
        --u.buf_keymap(bufnr, "n", "<leader>vsd", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>")

        -- vim.o.updatetime = 200
        -- vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })]])

        vim.diagnostic.config({
          virtual_text = {
            prefix = "●",
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })

        -- subrayado ondulado (squiggly) como VSCode, con color por severidad
        local diag_undercurl = {
          Error = "#f14c4c",
          Warn = "#cca700",
          Info = "#4fc1ff",
          Hint = "#6ce15e",
        }
        for kind, color in pairs(diag_undercurl) do
          vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. kind, { undercurl = true, sp = color })
        end

        opts.desc = "Buffer diagnostics"
        keymap.set("n", "<leader>tsd", function() Snacks.picker.diagnostics() end, opts)
        --u.buf_keymap(bufnr, "n", "<leader>vsd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>")

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        -- on_attach(cfg, bufnr): cfg primero, bufnr segundo (ev.buf = el buffer
        -- al que se attachó el cliente LSP)
        require("lsp_signature").on_attach({
          hint_enable = false,
          hi_parameter = "QuickFixLine",
          handler_opts = {
            border = vim.g.floating_window_border,
          },
        }, ev.buf)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup {
      -- eslint-lsp NO se auto-habilita: eslint lo maneja none-ls (source de
      -- extras, gated por config en el repo). Sin esto, eslint-lsp se attacha
      -- a todos los js/ts y duplica los diagnósticos.
      automatic_enable = { exclude = { "eslint" } },
      handlers = {
        -- TODO: default handlers for installed servers
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,

        -- TODO: lua lsp config server
        ["lua_ls"] = function()
          require("moise.plugins.config.lsp.lua_ls").setup(lspconfig, capabilities)
        end,

        -- TODO: terraform
        -- por ahora no lo uso, pero en su momento lo use bastante, se queda.
        --["terraformls"] = function()
        --  require("moise.plugins.config.lsp.terraformls").setup(lspconfig, capabilities)
        --end,

        ---- TODO: go
        ["gopls"] = function()
          require("moise.plugins.config.lsp.gopls").setup(lspconfig, capabilities)
        end,

        -- TODO: jsonls
        ["jsonls"] = function()
          require("moise.plugins.config.lsp.jsonls").setup(lspconfig, capabilities)
        end,

        -- TODO: yaml
        ["yamlls"] = function()
          require("moise.plugins.config.lsp.yamlls").setup(lspconfig, capabilities)
        end,

      }
    }
  end,
}
