local M = {}

M.logger = pcall(require, "plenary.log")

function M.toggle_scrolloff()
  if vim.o.scrolloff ~= 0 then
    vim.o.scrolloff = 0
    vim.api.nvim_clear_autocmds({ group = "scrolloff" })
  else
    vim.api.nvim_create_augroup("scrolloff", { clear = true })
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

M.find_git_root = function()
  local current_dir = vim.fn.expand("%:p:h")

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return current_dir
  end
  return git_root
end


return M
