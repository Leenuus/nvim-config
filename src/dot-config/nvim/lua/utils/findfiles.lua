local find_git_root = require("helpers").find_git_root
local toggler = require("helpers").toggler
local path = require("plenary.path")

local excluded = {
  "build",
  "target",
  "Pipfile*",
  "node_modules",
  "venv",
  "__pycache__",
  ".git",
}

local base_find_command = {
  "fd",
  "-t",
  "f",
  "-L",
}

for _, v in ipairs(excluded) do
  table.insert(base_find_command, "-E")
  table.insert(base_find_command, v)
end

vim.g.find_files_ignore = true
vim.g.find_files_mode = 3

local function cwd()
  return vim.fn.getcwd(0)
end

local function cfd()
  local dir = vim.fn.expand("%:p:h")
  if string.match(dir, "^.-://") then
    dir = cwd()
  end
  return dir
end

local find_files_modes = {
  [1] = cfd,
  [2] = find_git_root,
  [3] = cwd,
  ["1 cfd"] = cfd,
  ["2 git"] = find_git_root,
  ["3 cwd"] = cwd,
}

local function find_files(search_path)
  local find_command = {}
  for _, v in ipairs(base_find_command) do
    table.insert(find_command, v)
  end

  if not vim.g.find_files_ignore then
    table.insert(find_command, "-H")
    table.insert(find_command, "-I")
  end

  local dir = find_files_modes[vim.g.find_files_mode]()

  local p = path:new(search_path)
  if search_path == "" or not p:is_dir() then
    search_path = dir
  end

  local opts = {
    cwd = search_path,
    find_command = find_command,
  }

  require("telescope.builtin").find_files(opts)
end

local function live_grep(search_path)
  local glob_pattern = {}
  for _, v in ipairs(excluded) do
    table.insert(glob_pattern, "!" .. v)
  end

  local dir = find_files_modes[vim.g.find_files_mode]()
  local p = path:new(search_path)
  if search_path == "" or not p:is_dir() then
    search_path = dir
  end

  local additional_args = vim.g.find_files_ignore and {} or {
    "--hidden",
    "--no-ignore",
  }

  local opts = {
    cwd = search_path,
    glob_pattern = glob_pattern,
    additional_args = additional_args,
  }

  require("telescope.builtin").live_grep(opts)
end

vim.api.nvim_create_user_command("FindFiles", function(args)
  local p = args.args
  find_files(p)
end, { nargs = "?", complete = "dir", bar = true })

vim.api.nvim_create_user_command("LiveGrep", function(args)
  local p = args.args
  live_grep(p)
end, { nargs = "?", complete = "dir", bar = true })

-- NOTE: create commands to toggle ignore
toggler("find_files_ignore", "FindFilesIgnore", false, false)

vim.api.nvim_create_user_command("FindFilesMode", function()
  vim.ui.select(vim.tbl_keys(find_files_modes), {
    prompt = "select find files mode",
  }, function(choice)
    if choice then
      vim.g.find_files_mode = choice
    end
  end)
end, { bar = true })
