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
    cwd = function()
      return vim.fn.expand("%:h")
    end,
    find_command = base_find_command,
  },
  ["(current file)hidden, ignore"] = {
    cwd = function()
      return vim.fn.expand("%:h")
    end,
    find_command = find_all_command,
  },
  ["(workdir)"] = {
    cwd = function()
      return vim.fn.getcwd()
    end,
    find_command = base_find_command,
  },
  ["(workdir)hidden, ignore"] = {
    cwd = function()
      return vim.fn.getcwd()
    end,
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
}

local function find_files()
  -- NOTE: pitfall, deep copy!
  local opts = vim.deepcopy(find_files_options[find_files_mode])
  -- NOTE: some dir should never be searched
  if vim.tbl_contains(no_search_dirs, vim.fn.getcwd()) then
    vim.cmd("cd %:p:h")
  end
  if vim.tbl_contains(no_search_dirs, vim.fn.getcwd()) then
    print("This is not a good idea to search in " .. vim.fn.getcwd())
  else
    opts["cwd"] = opts["cwd"]()
    require("telescope.builtin").find_files(opts)
  end
end

local glob_pattern = {}

for _, e in ipairs(excluded) do
  vim.list_extend(glob_pattern, { string.format("!%s", e) })
end

-- live grep
local function grep_file_dir()
  local dir = vim.fn.expand("%:h")
  require("telescope.builtin").live_grep({
    cwd = dir,
    glob_pattern = glob_pattern,
  })
end

local function grep_git_root()
  local git_root = find_git_root()
  require("telescope.builtin").live_grep({
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

vim.api.nvim_create_user_command("GrepCwd", grep_file_dir, {})
vim.api.nvim_create_user_command("GrepGitRoot", grep_git_root, {})
vim.api.nvim_create_user_command("FindFiles", find_files, {})
vim.api.nvim_create_user_command("SearchMode", select_search_file_mode, {})
vim.api.nvim_create_user_command("QuickFiles", quick_files, {})
