return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = false,
  opts = {
    auto_close = true,
    position = "left",
    mode = "workspace_diagnostics",
    action_keys = {
      -- NOTE:
      -- map to {} to remove a mapping, for example:
      close = "q",
      cancel = "<esc>",
      refresh = "r",
      jump = { "<cr>", "<2-leftmouse>" },
      open_split = { "<c-s>" },
      open_vsplit = { "<c-p>" },
      open_tab = { "<c-t>" },
      jump_close = { "o" },
      toggle_mode = "m",
      switch_severity = "s",
      toggle_preview = "P",
      hover = {},
      preview = "p",
      open_code_href = "c",
      close_folds = { "zM", "zm" },
      open_folds = { "zR", "zr" },
      toggle_fold = { "zA", "za" },
      previous = "k",
      next = "j",
      help = "?",
    },
  },
}
