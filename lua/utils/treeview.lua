local function tree()
  local cwd = require("helpers").find_git_root()
  local p = vim.system({ "tree", "--gitignore", cwd }, { text = true }):wait()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, vim.split(p.stdout, "\n"))
  vim.api.nvim_set_option_value("ft", "tree", { buf = buf })
  vim.api.nvim_open_win(buf, true, {
    split = "left",
    win = 0,
    width = 40,
  })
end

vim.api.nvim_create_user_command("TreeOpen", tree, {})
