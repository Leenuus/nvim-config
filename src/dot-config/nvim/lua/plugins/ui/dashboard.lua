return {
  dir = "~/Projects/Neovims/dashboard-nvim",
  event = "VimEnter",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    require("config.dashboard")
  end,
  enabled = function()
    return vim.env["nvimpager"] ~= '1'
  end,
}
