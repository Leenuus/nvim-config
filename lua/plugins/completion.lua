return {
  { "williamboman/mason.nvim", config = true },
  -- "williamboman/mason-lspconfig.nvim",
  { "j-hui/fidget.nvim", opts = {} },
  { "neovim/nvim-lspconfig" },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({ enable_autosnippets = true })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-S>"] = cmp.mapping.close_docs(),
          ["<C-D>"] = cmp.mapping.open_docs(),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<C-N>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = false,
              })()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<C-P>"] = cmp.config.disable,
          ["<C-y>"] = cmp.config.disable,
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer", keyword_length = 3 },
          -- { name = "nvim_lua" },
        },
        window = {
          completion = {
            border = "rounded",
            scrollbar = true,
          },
          documentation = {
            border = "rounded",
          },
        },
        experimental = {
          ghost_text = false,
        },
        formatting = {
          fields = {
            "kind",
            "abbr",
            "menu",
          },
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "Lsp",
              luasnip = "Luasnip",
              path = "Path",
              buffer = "Buffer",
              nvim_lua = "Vim",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },
}
