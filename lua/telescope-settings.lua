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

smap("l", require("telescope.builtin").resume)
smap("h", require("telescope.builtin").help_tags)
smap("M", function()
  require("telescope.builtin").man_pages({ sections = { "ALL" } })
end)
smap("s", require("telescope.builtin").builtin, "Show telescopes")
smap("g", "<cmd>LiveGrepGitRoot<cr>", "Grep Git root")
smap("G", "<cmd>LiveGrepFileDir<cr>", "Grep current File dir")
smap("k", "<cmd>Telescope keymaps<cr>", "Show Keymaps")

local find_command = {
  "fd",
  "-H",
  "-E",
  ".git",
  "-E",
  "*build*",
  "-E",
  "*target*",
}

smap("f", function()
  require("telescope.builtin").find_files({
    hidden = true,
    no_ignore = true,
    cwd = find_git_root(),
    find_command = find_command,
  })
end)
nmap("<leader><space>", function()
  require("telescope.builtin").find_files({ cwd = find_git_root() })
end)

smap("F", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.getcwd(),
    hidden = true,
    no_ignore = false,
    find_command = find_command,
  })
end)

smap("/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end)

smap("c", function()
  vim.cmd("Telescope neoclip")
end)

smap("C", "<cmd>Telescope colorscheme<cr>")
smap("m", function()
  if package.loaded["noice"] ~= nil then
    return "<cmd>Telescope noice<cr>"
  else
    return "<cmd>messages<cr>"
  end
end, { expr = true, desc = "search for messages" })
