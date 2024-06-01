-- TODO:
-- 1. man page previewer
-- 2. delete marks

-- FIXME:
-- 1. jump to line:col doesn't work for vertical split window open

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
-- local logger = require("plenary.log")

local config = vim.fn.stdpath("config")
local manmarks_file = config .. "/.manmarks.jsonl"

local function set_mark(name)
  local man = vim.fn.expand("%")
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  if name == nil then
    name = string.format("%s %s:%s", man, line, col)
  end
  local mark = { man = man, line = line, col = col, name = name }
  local mark_str = vim.json.encode(mark) .. "\n"
  local marks = io.open(manmarks_file, "a")
  if marks == nil then
    vim.notify("fail to open manmarks file")
    return
  end
  marks:write(mark_str)
  marks:close()
end

local function go_marks(opts)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = "go to manpages marks",
        finder = finders.new_oneshot_job({
          "cat",
          manmarks_file,
        }, {
          entry_maker = function(entry)
            entry = vim.json.decode(entry)
            return {
              value = entry,
              display = entry.name,
              ordinal = entry.name,
            }
          end,
        }),

        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          local opener = function(open_cmd)
            return function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              local file = selection.value.man
              local line = selection.value.line
              local col = selection.value.col
              vim.cmd(string.format("%s +call\\ cursor(%s,%s) %s", open_cmd, line, col, file))
            end
          end

          actions.select_default:replace(opener("edit"))
          actions.select_horizontal:replace(opener("new"))
          actions.select_vertical:replace(opener("vnew"))
          actions.select_tab:replace(opener("tabnew"))

          return true
        end,
      })
      :find()
end

vim.api.nvim_create_user_command("ManSetMark", function()
  vim.ui.input({ prompt = "Bookmark Name?" }, function(input)
    set_mark(input)
  end)
end, {})

vim.api.nvim_create_user_command("ManGetMarks", go_marks, {})
