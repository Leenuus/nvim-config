vim.g.DEBUG = true
local log = require("plenary.log").new({
  plugin = "redir",
})

local function redir_open_win(buf, vertical, reuse_win_p)
  if not reuse_win_p or vim.g.redir_win == nil then
    local win = vim.api.nvim_open_win(buf, true, {
      vertical = vertical,
    })
    vim.api.nvim_create_autocmd("WinClosed", {
      pattern = { string.format("%d", win) },
      callback = function()
        vim.g.redir_win = nil
      end,
    })
    vim.g.redir_win = win
  else
    vim.api.nvim_win_set_buf(vim.g.redir_win, buf)
  end
end

local function redir_vim_command(cmd, vertical, reuse_win_p)
  vim.cmd("redir => output")
  vim.cmd("silent " .. cmd)
  vim.cmd("redir END")
  local output = vim.fn.split(vim.g.output, "\n")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, output)

  redir_open_win(buf, vertical, reuse_win_p)
end

local function redir_shell_command(cmd, lines, vertical, reuse_win_p)
  cmd[1] = cmd[1]:match("^!([^%s]*)")

  local buf = vim.api.nvim_create_buf(false, true)

  local stdin
  if #lines == 0 then
    stdin = false
  else
    stdin = lines
  end

  redir_open_win(buf, vertical, reuse_win_p)

  if vim.g.DEBUG then
    local report = string.format(
      [[cmd: %s
lines: %s
stdin: %s
buf: %d
]],
      vim.inspect(cmd),
      vim.inspect(lines),
      vim.inspect(stdin),
      buf
    )
    log.info(report)
  end

  vim.system(cmd, {
    text = true,
    stdout = function(err, stdout)
      vim.schedule_wrap(function()
        if stdout ~= nil then
          local output = vim.fn.split(stdout, "\n")
          if vim.g.DEBUG then
            log.info("stdout: " .. vim.inspect(output))
          end
          vim.api.nvim_buf_set_lines(buf, -2, -1, false, output)
        end
      end)()
    end,
    stdin = stdin,
  }, function(completed)
    -- NOTE:
    -- placeholder to make call async
  end)
end

-- reference
-- https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
local function Redir(args)
  -- FIXME: !awk '{ print "good" }'
  -- fargs = { "!awk", "'{", "print", '"good"', "}'" },
  local cmd = args.fargs
  local vertical = args.smods.vertical
  local reuse_win_p = not args.bang

  if vim.g.DEBUG then
    log.info(vim.inspect(args))
  end

  if string.match(cmd[1], "^!") then
    local range = args.range
    local lines
    if range == 0 then
      lines = {}
    else
      local line1 = args.line1 - 1
      local line2 = args.line2
      line2 = line1 == line2 and line1 + 1 or line2
      lines = vim.api.nvim_buf_get_lines(0, line1, line2, false)
    end

    redir_shell_command(cmd, lines, vertical, reuse_win_p)
  else
    redir_vim_command(args.args, vertical, reuse_win_p)
  end
end

vim.api.nvim_create_user_command("Redir", Redir, {
  nargs = "+",
  complete = "command",
  range = true,
  bang = true,
})
vim.cmd([[cabbrev R Redir]])

vim.api.nvim_create_user_command("Mes", function()
  vim.cmd("Redir messages")
end, {})
vim.cmd([[cabbrev M Mes]])

local function evaler(range)
  return function()
    local line = vim.fn.getline(1)
    local it = string.match(line, "^#!(.*)")

    local cmd = string.format("%sRedir !", range)

    if it and it ~= "" then
      vim.cmd(cmd .. it)
    else
      vim.fn.feedkeys(":" .. cmd, "tn")
    end
  end
end

vim.api.nvim_create_user_command("EvalFile", function(args)
  evaler("%")()
end, { bar = true })
vim.api.nvim_create_user_command("EvalLine", function(args)
  evaler(".")()
end, { bar = true })
vim.api.nvim_create_user_command("EvalRange", function(args)
  evaler("'<,'>")()
end, { bar = true })
