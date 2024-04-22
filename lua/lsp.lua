local logger = require("helpers").logger
local lmap = require("helpers").map_leader
local nmap = require("helpers").map_normal
local imap = require("helpers").map_insert
local map = require("helpers").map

-- TODO: look up more functions in vim.lsp.buf[]
local on_attach = function(_, bufnr)
  lmap("la", function()
    vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
  end, "Code Action")
  lmap("ls", require("telescope.builtin").lsp_document_symbols, "Doc Symbols")
  lmap("lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
  nmap("gh", vim.lsp.buf.hover, "goto [H]over")
  nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
  nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
  nmap("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
  nmap("gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")
  nmap("gD", vim.lsp.buf.declaration, "goto Declaration")

  map({ "i", "n" }, "<C-P>", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("Q", vim.lsp.buf.format, "Format Code")
  lmap("lr", vim.lsp.buf.rename, "Rename with Lsp")
end

lmap("lr", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, "Rename Variable With TreeSitter")

nmap("Q", function()
  -- NOTE: seems this function return false when no acitve clients attached to buffer
  -- local clients = vim.lsp.get_active_clients({ bufnr = 0 }) == nil
  -- if clients == false then
  -- logger.info("no formatter")
  -- else
  -- logger.info(vim.inspect(clients))
  -- end
end, "Format Code")

require("mason").setup()
require("mason-lspconfig").setup()

-- NOTE: for supported lsp list, checkout here
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
local ensure_installed_servers = {
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  -- awk_ls = {},
  ast_grep = {},
  asm_lsp = {},
  bashls = {},
  cmake = {},
  -- NOTE: for makefile
  ["autotools_ls"] = {},
  vimls = {},
  yamlls = {},
  clangd = {},
  taplo = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  -- NOTE:
  --  If you want to override the default filetypes that your language server will attach to you can
  --  define the property 'filetypes' to the map in question.
  html = { filetypes = { "html", "twig", "hbs" } },
  zls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) or capabilities
-- pcall(require, "cmp_nvim_lsp")

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(ensure_installed_servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = ensure_installed_servers[server_name],
      filetypes = (ensure_installed_servers[server_name] or {}).filetypes,
    })
  end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
-- TODO: luasnip setup
luasnip.config.setup({})

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
    end, { "i", "s", "c" }),
    ["<S-Tab>"] = cmp.config.disable,
    ["<C-P>"] = cmp.config.disable,
    ["<C-y>"] = cmp.config.disable,
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
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
      })[entry.source.name]
      return vim_item
    end,
  },
})
