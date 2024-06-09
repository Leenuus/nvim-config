local opts = {
  timeout = 3000,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.3)
  end,
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { zindex = 100 })
  end,
}

return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup(opts)
    -- vim.notify = require("notify")
  end,
}
