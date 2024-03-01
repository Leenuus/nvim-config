-- Popup message when recording

vim.api.nvim_create_augroup("recording", { clear = true })

local noption = {
  title = "Recording",
  timeout = 1,
  hide_from_history = true,
  icon = ''
}
local level = vim.log.levels.INFO

vim.api.nvim_create_autocmd("RecordingEnter", {
  pattern = "*",
  callback = function()
-- TODO: a maybe needed error handling for `require`
    require("notify")("Start Recording", level, noption)
  end,
  group = "recording",
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
-- TODO: a maybe needed error handling for `require`
    require("notify")("Stop Recording", level, noption)
  end,
  group = "recording",
})