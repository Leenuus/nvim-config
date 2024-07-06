local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({ enable_autosnippets = true })

vim.keymap.set({ "i", "s" }, "<C-]>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

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
    ["<C-N>"] = cmp.config.disable,
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
    { name = "buffer",  keyword_length = 3 },
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
        ["vim-dadbod-completion"] = "SQL",
      })[entry.source.name] or entry.source.name
      return vim_item
    end,
  },
})

cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})
