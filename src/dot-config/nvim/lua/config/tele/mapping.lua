local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

local opener = function(direction)
  return function(p)
    local old = vim.o.splitbelow
    local old1 = vim.o.splitright
    if direction == "left" then
      vim.o.splitright = false
      actions.select_vertical(p)
    elseif direction == "right" then
      vim.o.splitright = true
      actions.select_vertical(p)
    elseif direction == "above" then
      vim.o.splitbelow = false
      actions.select_horizontal(p)
    elseif direction == "below" then
      vim.o.splitbelow = true
      actions.select_horizontal(p)
    else
      actions.select_default(p)
    end
    vim.o.splitbelow = old
    vim.o.splitright = old1
  end
end

return {
  n = {
    ["<Tab>"] = actions.toggle_selection,
    ["\\"] = actions.select_vertical,
    ["-"] = actions.select_horizontal,
    ["J"] = opener("below"),
    ["K"] = opener("above"),
    ["H"] = opener("left"),
    ["L"] = opener("right"),
    ["q"] = actions.close,
    ["<Left>"] = actions.cycle_history_prev,
    ["<Right>"] = actions.cycle_history_next,
    ["<Up>"] = actions.cycle_history_prev,
    ["<Down>"] = actions.cycle_history_next,
  },
  i = {
    ["<Left>"] = actions.cycle_history_prev,
    ["<Right>"] = actions.cycle_history_next,
    ["<C-P>"] = actions.select_tab,
    ["<C-J>"] = opener("below"),
    ["<C-K>"] = opener("above"),
    ["<C-H>"] = opener("left"),
    ["<C-L>"] = opener("right"),
    ["<C-D>"] = actions.preview_scrolling_down,
    ["<C-U>"] = actions.preview_scrolling_up,
    ["<C-A>"] = action_layout.toggle_preview,
  },
}
