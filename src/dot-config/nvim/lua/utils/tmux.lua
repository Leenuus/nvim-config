local function tmux_open(direction, cmd)
  local pwd = vim.fn.getcwd(0)
  vim.cmd(string.format([[silent !tmux new-window %s -c '%s' %s]], direction, pwd, cmd))
end

vim.api.nvim_create_user_command("Tmux", function(args)
  local direction = args.bang and "-b" or "-a"
  local cmd = args.args
  tmux_open(direction, cmd)
end, { bar = true, nargs = 1, bang = true })

vim.api.nvim_create_user_command("T", function(args)
  local direction = args.bang and "-b" or "-a"
  local cmd = args.args
  tmux_open(direction, cmd)
end, { bar = true, nargs = 1, bang = true })
