-- NOTE: https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) or capabilities
end)
local lspconfig
pcall(function()
  lspconfig = require("lspconfig")
end)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
local servers = {
  "clangd",
  "rust_analyzer",
  "tsserver",
  "lua_ls",
  "jsonls",
  "bashls",
  "yamlls",
  "gopls",
  "pyright",
  "ruff",
  "sqlls",
}

-- NOTE: lua settings
pcall(function()
  require("neodev").setup({
    library = {
      enabled = true,
      runtime = true,
      types = true,
    },
    setup_jsonls = true,
    lspconfig = true,
    pathStrict = true,
  })
end)

if lspconfig then
  for _, server in ipairs(servers) do
    if lspconfig[server] ~= nil then
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    else
      -- vim.log.levels.INFO(server .. "not valid")
    end
  end
end
