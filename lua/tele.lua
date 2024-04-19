local h = require("helpers")
local logger = h.logger
local nmap = h.map_normal

local function smap(lhs, rhs, opts)
  if type(opts) == "string" then
    vim.keymap.set("n", "<leader>s" .. lhs, rhs, { desc = opts })
  elseif type(opts) == "table" or type(opts) == "nil" then
    vim.keymap.set("n", "<leader>s" .. lhs, rhs, opts)
  else
    logger.debug("Fail to set keymap, options: ", vim.inspect(opts))
  end
end

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      n = {
        ["<Tab>"] = actions.toggle_selection,
        ["\\"] = actions.select_vertical,
        ["-"] = actions.select_horizontal,
      },
      i = {
        ["<C-P>"] = actions.select_vertical,
        ["<C-S>"] = actions.select_horizontal,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local find_git_root = require("helpers").find_git_root

smap("l", require("telescope.builtin").resume, "Resume telescope")
smap("h", require("telescope.builtin").help_tags, "Find Helps")
smap("M", function()
  require("telescope.builtin").man_pages({ sections = { "ALL" } })
end, "Find man pages")
smap("s", require("telescope.builtin").builtin, "Show telescopes")
smap("k", "<cmd>Telescope keymaps<cr>", "Show Keymaps")

local DEFAULT_FIND_FILES_MODE = "default"
local find_files_mode = DEFAULT_FIND_FILES_MODE

local base_find_command = {
  "fd",
  "-E",
  "\\.git",
  "-E",
  "__pycache__",
  "-t",
  "f",
}

local find_files_options = {
  [DEFAULT_FIND_FILES_MODE] = {
    cwd = find_git_root,
    find_command = base_find_command,
  },
  ["hidden"] = {
    cwd = find_git_root,
    find_command = vim.list_extend(vim.deepcopy(base_find_command), { "-H" }),
  },
  ["hidden, ignore"] = {
    cwd = find_git_root,
    find_command = vim.list_extend(vim.deepcopy(base_find_command), { "-H", "-I" }),
  },
}

smap("F", function()
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
end, "Change File Searching Mode")

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
nmap("<leader><space>", find_files)

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

smap("g", live_grep_git_root, "Grep Git root")
smap("G", live_grep_file_dir, "Grep current File dir")

smap("/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, "Search Current buffer")

smap("c", function()
  vim.cmd("Telescope neoclip")
end, "Search Clipboard")

smap("t", "<cmd>Telescope colorscheme<cr>", "search colorscheme")

-- edit config
smap("C", function()
  local configpath = vim.fn.stdpath("config")
  require("telescope.builtin").find_files({
    cwd = configpath,
    hidden = false,
    no_ignore = true,
  })
end, "search config")

smap("m", function()
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

smap("f", function()
  vim.ui.select(common_files, {
    prompt = "Open common Used Files",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    -- logger.info("choice: ", choice)
    if choice then
      -- TODO: find that file in workdir root
      vim.cmd("e " .. choice)
    end
  end)
end)

smap("j", require("telescope.builtin").jumplist, "Jump list")
