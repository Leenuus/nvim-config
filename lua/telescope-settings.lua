-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local h = require("helpers")
local nmap = h.map_normal

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<C-p>"] = false,
        ["<C-n>"] = false,
      },
    },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

local function telescope_live_grep_open_files()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end

nmap("<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
nmap("<leader>sS", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
nmap("<leader>sl", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
nmap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nmap("<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
-- nmap("<leader>sG", "<cmd>LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
nmap("<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
-- See `:help telescope.builtin`
nmap("<leader><space>", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = false })
end, { desc = "Search all files in current dir" })
nmap("<leader>sf", require("telescope.builtin").git_files, { desc = "Search Git Files" })
nmap("<leader>sF", require("telescope.builtin").buffers, { desc = "Search Buffers" })

nmap("<leader>ss", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })
