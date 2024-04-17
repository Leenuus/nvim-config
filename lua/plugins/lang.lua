return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
  {
    -- renpy
    "chaimleib/vim-renpy",
  },
  {
    "folke/neodev.nvim",
    config = function()
      local common_plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" }
      require("neodev").setup({
        library = {
          enabled = true,
          runtime = true,
          types = true,
          -- plugins = true, -- installed opt or start plugins in packpath
          plugins = common_plugins
        },
        setup_jsonls = true,
        override = function(root_dir, library)
          local path = require('plenary.path')
          local p  = root_dir .. '/lua'
          if path:new(p):exists() then
            library.plugins = common_plugins
          else
            library.enabled = false
          end
        end,
        -- With lspconfig, Neodev will automatically setup your lua-language-server
        -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
        -- in your lsp start options
        lspconfig = true,
        pathStrict = true,
      })
    end,
  },
}
