-- copy file name
vim.api.nvim_create_user_command("CopyFileName", function()
  local f = vim.fn.expand("%:p")
  vim.fn.system(string.format("echo -n '%s' | xclip -selection clipboard", f))
end, { bar = true })

-- chmod +x current file
vim.api.nvim_create_user_command("ChmodPlusX", function()
  if vim.fn.getline(1):match("^#!") then
    vim.cmd("!chmod +x %")
  else
    print("No shellbang!")
  end
end, { bar = true })

-- go to git root
vim.api.nvim_create_user_command("GitRootCd", function()
  local d = require("helpers").find_git_root()
  vim.cmd("cd " .. d)
end, { bar = true })
