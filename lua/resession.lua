local M = {}

-- TODO:
-- 1. restore some more metadata
-- 2. delete existing sessions

local default_session_opt =
  "blank,buffers,curdir,folds,globals,help,localoptions,options,skiprtp,resize,tabpages,terminal,winpos,winsize"

local session_storage = vim.fn.stdpath("data") .. "/sessions"

if not vim.uv.fs_stat(session_storage) then
  vim.fn.system({
    "mkdir",
    "-p",
    session_storage,
  })
end

local pat = "(.*)%.vim$"

local function get_sessions()
  local items = {}
  for file, type in vim.fs.dir(session_storage) do
    if type == "file" and file:match(pat) ~= nil then
      table.insert(items, file)
    end
  end
  return items
end

local function new_session(session_name)
  if session_name == nil or session_name == "" then
    return
  end
  if session_name:match(pat) == nil then
    session_name = session_name .. ".vim"
  end
  vim.cmd("mksession! " .. session_storage .. "/" .. session_name)
end

local function format_session(session)
  return session:match(pat) or session
end

local function save_session()
  local function input_session()
    vim.ui.input({ prompt = "Enter Session Name" }, new_session)
  end
  -- select existing first
  local items = get_sessions()
  vim.ui.select(items, {
    prompt = "Overwrite Existing Session",
    format_item = format_session,
  }, function(choice)
    if choice ~= nil or choice == "" then
      new_session(choice)
    else
      input_session()
    end
  end)
end

local function restore_session()
  local items = get_sessions()
  vim.ui.select(items, {
    prompt = "Select a session to Restore",
    format_item = format_session,
  }, function(choice)
    if choice ~= nil and choice ~= "" then
      local s = session_storage .. "/" .. choice
      vim.cmd("source " .. s)
    end
  end)
end

vim.api.nvim_create_user_command("Projects", restore_session, {})
M.restore_session = restore_session
M.save_session = save_session

return M
