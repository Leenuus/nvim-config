-- NOTE:
-- - [X] detect and load .vim-session file automatically
-- - [X] save session on the fly
-- - [X] don't save keymap and options

-- TODO:
-- - [ ] remember all sessions files, telescope search and load

vim.g.loaded_session = nil

vim.defer_fn(function()
  vim.o.sessionoptions = "blank,buffers,curdir,folds,localoptions,help,tabpages,winsize,terminal"
end, 0)

local function load_session(path)
  if path == "" or path == nil then
    path = vim.fn.getcwd()
  end

  local session = path .. "/.vim-session"
  if vim.fn.filereadable(session) ~= 0 then
    if vim.g.loaded_session == nil then
      vim.cmd("source " .. session)
      vim.g.loaded_session = session
    else
      vim.notify("Session Already Loaded", vim.log.levels.INFO)
    end
  else
    vim.notify("No Session File Found", vim.log.levels.INFO)
  end
end

local function save_session(bang)
  local old = vim.o.sessionoptions
  if bang then
    -- NOTE: save global options and mapping
    vim.o.sessionoptions = vim.o.sessionoptions .. ",options"
  end
  local session
  if not vim.g.loaded_session then
    session = vim.fn.getcwd() .. "/.vim-session"
  else
    session = vim.g.loaded_session
  end
  vim.cmd("mksession! " .. session)
  vim.o.sessionoptions = old
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.fn.argc() == 0 then
      load_session()
    end
  end,
})

vim.api.nvim_create_user_command("SessionLoad", function(args)
  local path = args.args
  load_session(path)
end, { nargs = "?", complete = "dir", bar = true })

vim.api.nvim_create_user_command("SessionSave", function(args)
  local bang = args.bang
  save_session(bang)
end, { bang = true, bar = true })
