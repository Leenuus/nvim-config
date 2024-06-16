local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local config = vim.fn.stdpath("data")
local manmarks_file = config .. "/manmarks.jsonl"

local function set_mark(name)
  if vim.o.ft ~= "man" then
    return
  end
  local l = string.len("man://")
  local filename = vim.fn.expand("%")
  if name == nil then
    return
  end
  local lnum = vim.fn.line(".")
  local term = vim.fn.expand("<cWORD>")
  local pattern = string.format("\\V%s", vim.fn.escape(term, "\\"))
  local width = vim.api.nvim_win_get_width(0)
  local mark = { name = name, pattern = pattern, filename = filename, lnum = lnum, width = width }
  local mark_str = vim.json.encode(mark) .. "\n"
  local marks = io.open(manmarks_file, "a")
  if marks == nil then
    vim.notify("fail to open manmarks file")
    return
  end
  marks:write(mark_str)
  marks:close()
end

local function get_manmarks()
  local manmarks = {}
  for line in io.lines(manmarks_file) do
    local mark = vim.json.decode(line)
    table.insert(manmarks, mark)
  end
  return manmarks
end

local function go_marks(opts)
  opts = opts or {}
  local width = vim.api.nvim_win_get_width(0)
  vim.notify(string.format("%d", width))
  pickers
      .new(opts, {
        prompt_title = "go to manpages marks",
        finder = finders.new_table({
          results = get_manmarks(),
          entry_maker = function(e)
            local search_up
            if width == e.width then
              search_up = nil
            elseif width >= e.width then
              search_up = true
            else
              search_up = false
            end
            return {
              search_up = search_up,
              value = e.pattern,
              display = e.name,
              ordinal = e.name,
              filename = e.filename,
              lnum = e.lnum,
            }
          end,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          local function opener(open_cmd)
            return function()
              actions.close(prompt_bufnr)
              local e = action_state.get_selected_entry()
              local filename = e.filename
              local lnum = e.lnum
              local search_up = e.search_up

              local cmd = string.format("%s +%d %s", open_cmd, lnum, filename)
              vim.cmd(cmd)

              local pattern = e.value
              vim.notify(vim.inspect(search_up))
              if search_up then
                vim.notify(pattern)
                local flags = "bcW"
                vim.fn.search(pattern, flags)
              elseif search_up ~= nil then
                local flags = "cW"
                vim.fn.search(pattern, flags)
              end
            end
          end
          actions.select_default:replace(opener("edit"))
          actions.select_horizontal:replace(opener("split"))
          actions.select_vertical:replace(opener("vsplit"))
          actions.select_tab:replace(opener("tabedit"))

          return true
        end,
      })
      :find()
end

vim.api.nvim_create_user_command("ManSetMark", function()
  if vim.o.ft ~= "man" then
    return
  end
  vim.ui.input({ prompt = "Bookmark Name?" }, function(input)
    set_mark(input)
  end)
end, {})

vim.api.nvim_create_user_command("ManMarks", go_marks, {})
