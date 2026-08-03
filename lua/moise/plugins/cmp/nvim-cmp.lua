return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local present, cmp = pcall(require, "cmp")

    if not present then
      return
    end

    local lspkind = require "lspkind"

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
      preselect = cmp.PreselectMode.None,
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = "...",
        },
      },
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        --end,
        ["<CR>"] = cmp.mapping.confirm {
          select = true,
          behavior = cmp.ConfirmBehavior.Insert,
        },
        ["<C-y>"] = cmp.config.disable,
        ["<c-space>"] = cmp.mapping.complete(),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    }
  end,
}
