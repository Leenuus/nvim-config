local M = {}

M.find_git_root = function(file)
  local current_dir
  if file ~= nil then
    local f = require("plenary.path").new(file)
    if f:exists() then
      current_dir = f:parent().filename
    else
      current_dir = vim.fn.expand("%:p:h")
    end
  else
    current_dir = vim.fn.expand("%:p:h")
  end

  if string.match(current_dir, "^.-://") then
    current_dir = vim.fn.getcwd()
  end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    return current_dir
  end

  return git_root
end

function M.nop() end

function M.toggler(var_name, cmd_prefix, buffer, reverse)
  local scope = buffer and "b" or "g"
  local funcs
  if reverse then
    funcs = {
      toggle = function()
        vim[scope][var_name] = not vim[scope][var_name]
      end,
      disable = function()
        vim[scope][var_name] = true
      end,
      enable = function()
        vim[scope][var_name] = false
      end,
    }
  else
    funcs = {
      toggle = function()
        vim[scope][var_name] = not vim[scope][var_name]
      end,
      disable = function()
        vim[scope][var_name] = false
      end,
      enable = function()
        vim[scope][var_name] = true
      end,
    }
  end
  vim.api.nvim_create_user_command(cmd_prefix .. "Disable", funcs.disable, { bar = true })
  vim.api.nvim_create_user_command(cmd_prefix .. "Enable", funcs.enable, { bar = true })
  vim.api.nvim_create_user_command(cmd_prefix .. "Toggle", funcs.toggle, { bar = true })
  return funcs
end

function M.capitalize(s)
  local first = string.sub(s, 1, 1):upper()
  return first .. string.sub(s, 2)
end

return M
