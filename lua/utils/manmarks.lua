-- NOTE: line jumping and line searching won't work perfectly
-- for roff man page system
-- final solution should be transform man pages to common used
-- format like markdown file


local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local config = vim.fn.stdpath("data")
local manmarks_file = config .. "/manmarks.jsonl"

local function set_mark(name)
  local l = string.len('man://')
  local man = vim.fn.expand("%"):sub(l + 1)
  if name == nil then
    return
  end
  local line = vim.fn.getline(".")
  local regex = string.format("\\V%s", vim.fn.escape(line, "\\"))
  local mark = { man = man, name = name, pattern = regex }
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
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local file = selection.value.man
            local pattern = selection.value.pattern
            vim.cmd(string.format("Man %s", file))
            local flags = "cw"
            vim.fn.search(pattern, flags)
          end)

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

vim.api.nvim_create_user_command("ManMarks", go_marks, {})
