local h = require("helpers")
local nmap = h.map_normal

local function smap(lhs, rhs, opts)
  vim.keymap.set("n", "<leader>s" .. lhs, rhs, opts)
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
})

pcall(require("telescope").load_extension, "fzf")

local function find_git_root()
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

local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

smap("l", require("telescope.builtin").resume)
smap("h", require("telescope.builtin").help_tags)
smap("m", require("telescope.builtin").man_pages)
smap("s", require("telescope.builtin").builtin)
smap("g", "<cmd>LiveGrepGitRoot<cr>")
smap("f", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true, cwd = find_git_root() })
end)

nmap("<leader><space>", function()
  require("telescope.builtin").find_files({ hidden = false, no_ignore = true, cwd = find_git_root() })
end)

smap("/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end)

