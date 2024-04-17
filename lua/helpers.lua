local M = {}

M.logger = require("plenary.log")

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

function M.map_insert(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("i", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("i", lhs, rhs, opts)
  else
    M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
  end
end

function M.map_normal(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("n", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("n", lhs, rhs, opts)
  else
    M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
  end
end

function M.map_visual(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("v", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("v", lhs, rhs, opts)
  else
    M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
  end
end

function M.map_operator(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("o", lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("o", lhs, rhs, opts)
  else
    M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
  end
end

function M.map_command(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("c", lhs, rhs, opts)
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("c", lhs, rhs, opts)
  else
    M.logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
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
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == "" then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    return cwd
  end
  return git_root
end

return M
