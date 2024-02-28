local M = {}

function M.setup_scrolloff()
  if vim.o.scrolloff ~= 0 then
    vim.o.scrolloff = 0
    vim.api.nvim_clear_autocmds({ group = "scrolloff" })
  else
    vim.api.nvim_create_augroup("scrolloff", {})
    vim.api.nvim_create_autocmd({ "WinEnter", "WinResized" }, {
      pattern = "*",
      group = "scrolloff",
      callback = function()
        local height = vim.api.nvim_win_get_height(0)
        vim.o.scrolloff = math.floor(height / 2)
      end,
    })
  end
end

function M.map_insert(lhs, rhs, options)
  vim.keymap.set("i", lhs, rhs, options)
end

function M.map_normal(lhs, rhs, options)
  vim.keymap.set("n", lhs, rhs, options)
end

function M.map_visual(lhs, rhs, options)
  vim.keymap.set("v", lhs, rhs, options)
end

function M.map_operator(lhs, rhs, options)
  vim.keymap.set("o", lhs, rhs, options)
end

function M.map_command(lhs, rhs, options)
  vim.keymap.set("c", lhs, rhs, options)
end

-- toggle options
function M.map_toggle(lhs, rhs, desc)
  local d = "[T]oggle " .. desc
  local l = "<leader>t" .. lhs
  M.map_normal(l, rhs, { desc = d })
end

return M
