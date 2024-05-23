-- NOTE: hardtime's idea is good
-- however its default doesn't make sense
-- and it imports redundant dependencies nui.nvim
-- its hints works badly
-- max_count, which is same to all keybindings, does not make sense
local opts = {
  disable_mouse = false,
  max_time = 1000,
  max_count = 5,
  hint = true,
  notification = true,
  allow_different_key = false,
  enabled = true,
  restriction_mode = "hint",
  restricted_keys = {
    ["J"] = { "n", "x" },
    ["K"] = { "n", "x" },
  },
  disabled_keys = {},
  hints = {
    ["[JK]"] = {
      message = function(keys)
        return "Use " .. "marks or search" .. " instead of " .. keys
      end,
      length = 1,
    },
    ["[ia][{}]"] = {
      message = function(keys)
        return "Use " .. (keys:sub(1, 1) == "i" and "io" or "ao") .. " instead of " .. keys
      end,
      length = 2,
    },
  },
}

return {
  -- "m4xshen/hardtime.nvim",
  dir = "~/Projects/Neovims/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = opts,
  enabled = false,
}
