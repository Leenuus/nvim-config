local opts = {
  transparent = false,     -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
}

return {
  { "xiyaowong/transparent.nvim" },
  {
    "/folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      require("tokyonight").setup(opts)
    end,
  },
}
