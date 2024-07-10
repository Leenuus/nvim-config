local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local default_projects_file = vim.fn.expand("~/Projects/projects.yaml")

local function get_projects(projects_file)
  projects_file = projects_file or default_projects_file
  local s = vim
    .system({
      "yq",
      "-oj",
      ".",
      projects_file,
    })
    :wait().stdout or ""
  return vim.json.decode(s)
end

local function find_projects(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Select Projects",
      finder = finders.new_table({
        results = get_projects(),
        entry_maker = function(e)
          return {
            value = e.path,
            ordinal = e.name,
            display = e.name,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        local function open_project()
          local s = action_state.get_selected_entry().value
          s = vim.fn.expand(s)
          local file_stat = vim.uv.fs_stat(s)
          local dir = s
          local cmd = "FindFiles"
          if file_stat and file_stat.type == "file" then
            dir = vim.fn.fnamemodify(s, ":p:h")
            cmd = "e " .. s
          end

          actions.close(prompt_bufnr)
          vim.cmd(string.format("tabnew | tcd %s | %s", dir, cmd))
        end

        actions.select_tab:replace(open_project)
        actions.select_default:replace(open_project)

        return true
      end,
    })
    :find()
end

vim.api.nvim_create_user_command("Projects", function()
  find_projects()
end, { bar = true })
