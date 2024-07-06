return {
  -- TODO: use dbus bindings to write my own
  "keaising/im-select.nvim",
  enabled = false,
  config = function()
    require("im_select").setup({})
  end,
}
