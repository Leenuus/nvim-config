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

local function live_grep_file_dir()
  local file = vim.fn.expand("%:p")
  local dir = vim.fs.dirname(file)
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

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
vim.api.nvim_create_user_command("LiveGrepFileDir", live_grep_file_dir, {})

smap("l", require("telescope.builtin").resume, "Resume telescope")
smap("h", require("telescope.builtin").help_tags, "Find Helps")
smap("M", function()
  require("telescope.builtin").man_pages({ sections = { "ALL" } })
end, "Find man pages")
smap("s", require("telescope.builtin").builtin, "Show telescopes")
-- TODO: change live grep mode
smap("g", "<cmd>LiveGrepGitRoot<cr>", "Grep Git root")
smap("G", "<cmd>LiveGrepFileDir<cr>", "Grep current File dir")
smap("k", "<cmd>Telescope keymaps<cr>", "Show Keymaps")

local DEFAULT_FIND_FILES_MODE = "default"
local find_files_mode = DEFAULT_FIND_FILES_MODE

local find_files_options = {
  [DEFAULT_FIND_FILES_MODE] = {
    cwd = find_git_root,
    find_command = {
      "fd",
      "-E",
      "\\.git",
      "-t",
      "f",
    },
  },
  ["git root, with hidden"] = {
    cwd = find_git_root,
    -- NOTE: pitfall here, `vim.list_extend` change the dst list and return it
    find_command = {
      "fd",
      "-E",
      "\\.git",
      "-t",
      "f",
      "-H",
    },
  },
  ["cwd, all files"] = {
    -- NOTE: pitfall
    -- wrap it to avoid being evaluated at startup time
    -- this should be evaluated at runtime
    cwd = function()
      return vim.fn.expand("%:p:h")
    end,
    find_command = {
      "fd",
      "-E",
      "\\.git",
      "-t",
      "f",
      "-H",
      "-I",
    },
  },
}

smap("f", function()
  vim.ui.select(vim.tbl_keys(find_files_options), {
    prompt = "Select File Searching mode",
    -- how to display item to user
    format_item = function(item)
      return item
    end,
  }, function(choice)
    logger.info("choice: ", choice)
    find_files_mode = choice
  end)
end, "Change File Searching Mode")

local function find_files()
  -- NOTE: pitfall, deep copy!
  local opts = vim.deepcopy(find_files_options[find_files_mode])
  opts["cwd"] = opts["cwd"]()
  -- logger.info("options: ", opts)
  require("telescope.builtin").find_files(opts)
end
vim.api.nvim_create_user_command("FindFiles", find_files, {})
nmap("<leader><space>", find_files)

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
