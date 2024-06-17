local find_git_root = require("helpers").find_git_root

local DEFAULT_FIND_FILES_MODE = "(gitroot)"
local find_files_mode = DEFAULT_FIND_FILES_MODE

local excluded = {
  "*.pdf",
  "*build*",
  "*target*",
  "*Pipfile*",
  "node_modules",
  "venv",
  "__pycache__",
  ".git",
}

local base_find_command = {
  "fd",
  "-t",
  "f",
}

for _, e in ipairs(excluded) do
  vim.list_extend(base_find_command, { "-E", e })
end

local find_all_command = vim.list_extend(vim.deepcopy(base_find_command), { "-H", "-I" })

local function work_dir()
  return vim.fn.getcwd()
end

local function current_file()
  local cwd = vim.fn.expand("%:p:h")
  if string.match(cwd, "^.-://") then
    cwd = work_dir()
  end
  return cwd
end

local find_files_options = {
  [DEFAULT_FIND_FILES_MODE] = {
    cwd = find_git_root,
    find_command = base_find_command,
  },
  ["(gitroot)hidden, ignore"] = {
    cwd = find_git_root,
    find_command = find_all_command,
  },
  ["(current file)"] = {
    cwd = current_file,
    find_command = base_find_command,
  },
  ["(current file)hidden, ignore"] = {
    cwd = current_file,
    find_command = find_all_command,
  },
  ["(workdir)"] = {
    cwd = work_dir,
    find_command = base_find_command,
  },
  ["(workdir)hidden, ignore"] = {
    cwd = work_dir,
    find_command = find_all_command,
  },
}

local function select_search_file_mode()
  vim.ui.select(vim.tbl_keys(find_files_options), {
    prompt = "Select File Searching mode",
    -- how to display item to user
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      find_files_mode = choice
    end
  end)
end

local no_search_dirs = {
  vim.env["HOME"],
  "/tmp",
  "/",
}

local function find_files(options)
  options = options or {}
  local cwd
  local opts = vim.deepcopy(find_files_options[find_files_mode])
  if type(opts["cwd"]) == "function" then
    cwd = opts["cwd"]()
  else
    cwd = cwd
  end

  local op = vim.tbl_deep_extend("force", {
    opts.find_command,
    cwd = cwd,
  }, options)
  op.cwd = op.cwd or cwd

  if vim.tbl_contains(no_search_dirs, op.cwd) then
    vim.notify("This is not a good idea to search in " .. op.cwd)
    return
  end
  require("telescope.builtin").find_files(op)
end

local glob_pattern = {}

for _, e in ipairs(excluded) do
  vim.list_extend(glob_pattern, { string.format("!%s", e) })
end

-- live grep
local function livegrep(opts)
  opts = opts or {}

  print("mode", find_files_mode)
  local options = vim.deepcopy(find_files_options[find_files_mode])
  local cwd
  if type(options["cwd"]) == "function" then
    cwd = options["cwd"]()
  else
    cwd = cwd
  end
  print("cwd", cwd)

  opts = vim.tbl_deep_extend("force", {
    glob_pattern = glob_pattern,
  }, opts)
  print("cwd in")
  print(vim.inspect(opts.cwd))
  opts["cwd"] = opts["cwd"] or cwd
  print("final cwd", opts.cwd)

  require("telescope.builtin").live_grep(opts)
end

local function grep_git_root()
  local git_root = find_git_root()
  livegrep({
    cwd = git_root,
    glob_pattern = glob_pattern,
  })
end

local function quick_files()
  local harpoon_files = require("harpoon"):list()

  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  if #file_paths == 0 then
    find_files()
  else
    -- TODO: add normal mode binding to delete files
    local conf = require("telescope.config").values
    require("telescope.pickers")
        .new({}, {
          prompt_title = "QuickFiles",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
  end
end

vim.api.nvim_create_user_command("LiveGrep", function(opts)
  local cwd = opts["args"]
  if cwd == "" then
    cwd = nil
  end
  livegrep({ cwd = cwd })
end, {
  nargs = "?",
  complete = "dir",
})
vim.api.nvim_create_user_command("GrepGitRoot", grep_git_root, {})
vim.api.nvim_create_user_command("FindFiles", function(opts)
  local cwd = opts["args"]
  if cwd == "" then
    cwd = nil
  end
  find_files({ cwd = cwd })
end, { nargs = "?", complete = "dir" })
vim.api.nvim_create_user_command("SearchMode", select_search_file_mode, {})
vim.api.nvim_create_user_command("QuickFiles", quick_files, {})
