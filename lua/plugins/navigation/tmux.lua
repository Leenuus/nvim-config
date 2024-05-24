return {
  {
    dir = "~/Projects/Neovims/nvim-tmux-navigator",
    config = function()
      require("neovim-tmux-navigator").setup({
        use_default_keymap = true,
        cross_win = true,
        pane_nowrap = true,
      })
    end,
  },
}
