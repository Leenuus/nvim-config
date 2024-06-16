-- TODO: support help file for vim


local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local config = vim.fn.stdpath("data")
local manmarks_file = config .. "/manmarks.jsonl"

local function mark_new(name)
  if name == nil then
    return nil
  end
  local filename = vim.fn.expand("%")
  local lnum = vim.fn.line(".")
  local term = vim.fn.expand("<cWORD>")
  local pattern = string.format("\\V%s", vim.fn.escape(term, "\\"))
  local width = vim.api.nvim_win_get_width(0)
  local mark = { name = name, pattern = pattern, filename = filename, lnum = lnum, width = width }
  return mark
end

local function load_marks()
  local ok, value = pcall(function()
    local manmarks = {}
    local id = 1
    for line in io.lines(manmarks_file) do
      local mark = vim.json.decode(line)
      mark.id = id
      table.insert(manmarks, mark)
      id = id + 1
    end
    return manmarks
  end)
  if ok then
    return value
  else
    return {}
  end
end

local function dump_marks(marks)
  local f = io.open(manmarks_file, "w")
  if f ~= nil then
    for _, m in ipairs(marks) do
      local mark_str = string.format("%s\n", vim.json.encode(m))
      f:write(mark_str)
    end
    f:close()
  end
end

local function mark_delete(marks, id)
  local new_marks = {}
  for _, m in ipairs(marks) do
    if m.id ~= id then
      table.insert(new_marks, m)
    end
  end
  marks = new_marks
  return marks
end

local function set_new_mark()
  if vim.o.ft ~= "man" then
    return
  end
  vim.ui.input({ prompt = "Bookmark Name?" }, function(name)
    local marks = load_marks()
    local mark = mark_new(name)
    table.insert(marks, mark)
    for _, m in ipairs(marks) do
      m.id = nil
    end
    dump_marks(marks)
  end)
end

local function tele_marks(opts)
  opts = opts or {}
  local width = vim.api.nvim_win_get_width(0)
  local marks = load_marks()
  pickers
      .new(opts, {
        prompt_title = "go to manpages marks",
        finder = finders.new_table({
          results = marks,
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
              value = e.id,
              pattern = e.pattern,
              display = e.name,
              ordinal = e.name,
              filename = e.filename,
              lnum = e.lnum,
              id = e.id,
            }
          end,
        }),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          local function opener(open_cmd)
            return function()
              actions.close(prompt_bufnr)
              dump_marks(marks)
              local e = action_state.get_selected_entry()
              local filename = e.filename
              local lnum = e.lnum
              local search_up = e.search_up

              local cmd = string.format("%s +%d %s", open_cmd, lnum, filename)
              vim.cmd(cmd)

              local pattern = e.pattern
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

          map("n", "d", function()
            actions.close(prompt_bufnr)
            local e = action_state.get_selected_entry()
            local id = e.id
            marks = mark_delete(marks, id)
            dump_marks(marks)
          end)

          return true
        end,
      })
      :find()
end

vim.api.nvim_create_user_command("ManSetMark", set_new_mark, {})

vim.api.nvim_create_user_command("ManMarks", tele_marks, {})
