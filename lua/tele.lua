local logger = require("plenary.log").new({ level = "info", plugin = "telescope-config" })

local function smap(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("n", "<leader>s" .. lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("n", "<leader>s" .. lhs, rhs, opts)
  else
    -- @diagnostic disable-next-line: undefined-field
    logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
  end
end

local find_git_root = require("helpers").find_git_root

vim.keymap.set("n", "<leader>sl", require("telescope.builtin").resume, { desc = "Resume telescope" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Find Helps" })
vim.keymap.set("n", "<leader>sM", function()
  require("telescope.builtin").man_pages({ sections = { "ALL" } })
end, { desc = "Find man pages" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "Show telescopes" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Show Keymaps" })

local DEFAULT_FIND_FILES_MODE = "(gitroot)"
local find_files_mode = DEFAULT_FIND_FILES_MODE

local base_find_command = {
  "fd",
  "-E",
  "\\.git",
  "-E",
  "__pycache__",
  "-E",
  "venv",
  "-E",
  "node_modules",
  "-E",
  "*build*",
  "-E",
  "*target*",
  "-t",
  "f",
}

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

vim.keymap.set("n", "<leader>sF", function()
  vim.ui.select(vim.tbl_keys(find_files_options), {
    prompt = "Select File Searching mode",
    -- how to display item to user
    format_item = function(item)
      return item
    end,
  }, function(choice)
    logger.info("choice: ", choice)
    if choice then
      find_files_mode = choice
    end
  end)
end, { desc = "Change File Searching Mode" })

local no_search_dirs = {
  vim.env["HOME"],
  "/tmp",
}

local function find_files()
  -- NOTE: pitfall, deep copy!
  local opts = vim.deepcopy(find_files_options[find_files_mode])
  -- logger.info("mode: ", find_files_mode)
  -- logger.info("options: ", opts)
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
vim.api.nvim_create_user_command("FindFiles", find_files, {})
vim.keymap.set("n", "<leader><space>", find_files)

-- live grep
local function live_grep_file_dir()
  local dir = vim.fn.expand("%:p:h")
  require("telescope.builtin").live_grep({
    cwd = dir,
  })
end

local function live_grep_git_root()
  local git_root = find_git_root()
  require("telescope.builtin").live_grep({
    cwd = git_root,
  })
end

vim.keymap.set("n", "<leader>sg", live_grep_git_root, { desc = "Grep Git root" })
vim.keymap.set("n", "<leader>sG", live_grep_file_dir, { desc = "Grep current File dir" })

vim.keymap.set("n", "<leader>s/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Search Current buffer" })

vim.keymap.set("n", "<leader>sC", function()
  vim.cmd("Telescope neoclip")
end, { desc = "Search Clipboard" })

vim.keymap.set("n", "<leader>st", "<cmd>Telescope colorscheme<cr>", { desc = "search colorscheme" })

vim.keymap.set("n", "<leader>sm", function()
  if package.loaded["noice"] ~= nil then
    return "<cmd>Telescope noice<cr>"
  else
    return "<cmd>messages<cr>"
  end
end, { expr = true, desc = "search for messages" })

-- open common file
local common_files = {
  "Makefile",
  ".gitignore",
  "README.md",
}

vim.keymap.set("n", "<leader>sf", function()
  vim.ui.select(common_files, {
    prompt = "Open common Used Files",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      vim.cmd("e " .. choice)
    end
  end)
end)

vim.keymap.set("n", "<leader>sj", require("telescope.builtin").jumplist, { desc = "Jump list" })
vim.keymap.set("n", "<leader>sH", require("telescope.builtin").command_history, { desc = "Command History" })
