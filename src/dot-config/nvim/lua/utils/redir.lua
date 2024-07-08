local log = require("plenary.log").new({
  plugin = "redir",
})

local function redir_vim_command(cmd, vertical, reuse_win_p)
  vim.cmd("redir => output")
  vim.cmd("silent " .. cmd)
  vim.cmd("redir END")
  local output = vim.fn.split(vim.g.output, "\n")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, output)
  vim.api.nvim_open_win(buf, true, {
    vertical = vertical,
  })
end

local function redir_shell_command(cmd, lines, vertical, reuse_win_p)
  cmd[1] = cmd[1]:match("^!([^%s]*)")

  local buf = vim.api.nvim_create_buf(true, true)

  local stdin
  if #lines == 0 then
    stdin = false
  else
    stdin = lines
  end

  vim.api.nvim_open_win(buf, true, {
    vertical = vertical,
  })

  if vim.g.DEBUG then
    local report = string.format(
      [[cmd: %s
lines: %s
stdin: %s
]],
      vim.inspect(cmd),
      vim.inspect(lines),
      vim.inspect(stdin)
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
    redir_vim_command(cmd[1], vertical, reuse_win_p)
  end
end

vim.api.nvim_create_user_command("Redir", Redir, {
  nargs = 1,
  complete = "command",
  range = true,
  bang = true,
})
vim.cmd([[cabbrev R Redir]])

vim.api.nvim_create_user_command("Mes", function()
  vim.cmd("Redir messages")
end, {})
vim.cmd([[cabbrev M Mes]])

--
-- local interepters = {
--   python = "python",
--   sh = "bash",
--   bash = "bash",
--   fish = "fish",
--   lua = "luajit",
-- }
--
-- local function redir(range)
--   return function()
--     local line = vim.fn.getline(1)
--     local interepter = string.match(line, "^#!(.*)")
--
--     if not interepter then
--       local ft = vim.o.ft
--       interepter = interepters[ft]
--     end
--
--     if interepter then
--       vim.cmd(string.format("silent %sRedir !%s", range, interepter))
--     else
--       -- FIXME: setcmdline not work
--       vim.fn.setcmdline(string.format("silent %sRedir !", range))
--     end
--   end
-- end
--
-- vim.api.nvim_create_user_command("RedirEvalLine", redir("."), {})
-- vim.api.nvim_create_user_command("RedirEvalFile", redir("%"), {})
-- -- FIXME: not work well
-- -- vim.api.nvim_create_user_command("RedirEvalRange", redir("'<,'>"), {})
