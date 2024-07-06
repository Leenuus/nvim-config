return {
  {
    dir = "~/Projects/Neovims/nvim-tmux-navigator",
    event = "VeryLazy",

    config = function()
      require("neovim-tmux-navigator").setup({
        use_default_keymap = true,
      })
      vim.g.tmux_navigator_pane_nowrap = true
      vim.g.tmux_navigater_cross_win = true
    end,
  },
}
