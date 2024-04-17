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
      local plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" }
      require("neodev").setup({
        library = {
          enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
          -- these settings will be used for your Neovim config directory
          runtime = true, -- runtime path
          types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
          -- plugins = true, -- installed opt or start plugins in packpath
          -- you can also specify the list of plugins to make available as a workspace library
          plugins = plugins
        },
        setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
        -- for your Neovim config directory, the config.library settings will be used as is
        -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
        -- for any other directory, config.library.enabled will be set to false
        override = function(root_dir, library)
          local path = require('plenary.path')
          -- path('')
          local p  = root_dir .. 'lua'
          library.plugins = plugins
        end,
        -- With lspconfig, Neodev will automatically setup your lua-language-server
        -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
        -- in your lsp start options
        lspconfig = true,
        -- much faster, but needs a recent built of lua-language-server
        -- needs lua-language-server >= 3.6.0
        pathStrict = true,
      })
    end,
  },
}
