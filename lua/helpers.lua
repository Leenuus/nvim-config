local M = {}

M.find_git_root = function()
  local current_dir = vim.fn.expand("%:p:h")

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return current_dir
  end
  return git_root
end

return M
