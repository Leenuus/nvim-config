-- NOTE: https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) or capabilities

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
local servers = { "clangd", "rust_analyzer", "tsserver", "lua_ls", "jsonls", "bashls", "yamlls", "jedi_language_server", "pylsp" }

-- NOTE: lua settings
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

for _, server in ipairs(servers) do
  if lspconfig[server] ~= nil then
    lspconfig[server].setup({
      capabilities = capabilities,
    })
  else
    vim.log.levels.INFO(server .. "not valid")
  end
end
