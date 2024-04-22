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

function M.map(modes, lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set(modes, lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set(modes, lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

function M.map_insert(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("i", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("i", lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

function M.map_normal(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("n", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("n", lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

function M.map_visual(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("v", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("v", lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

function M.map_operator(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("o", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("o", lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

function M.map_command(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("c", lhs, rhs, opts)
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("c", lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

-- toggle options
function M.map_toggle(lhs, rhs, desc)
  local d = "[T]oggle " .. desc
  local l = "<leader>t" .. lhs
  M.map_normal(l, rhs, { desc = d })
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

M.find_git_root = function()
  local current_dir = vim.fn.expand("%:p:h")

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return current_dir
  end
  return git_root
end

function M.map_leader(lhs, rhs, opts)
  lhs = "<leader>" .. lhs
  if type(opts) == "string" then
    vim.keymap.set("n", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("n", lhs, rhs, opts)
  else
    if M.logger ~= nil then
      M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
    end
  end
end

return M
