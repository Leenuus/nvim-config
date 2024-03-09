-- Popup message when recording

local gp = vim.api.nvim_create_augroup("recording-notifications", { clear = true })

local noption = {
  title = "Recording",
  timeout = 1,
  hide_from_history = true,
  icon = "",
}
local level = vim.log.levels.INFO

vim.api.nvim_create_autocmd("RecordingEnter", {
  pattern = "*",
  callback = function()
    require("notify")("Start Recording", level, noption)
  end,
  group = gp,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  pattern = "*",
  callback = function()
    require("notify")("Stop Recording", level, noption)
  end,
  group = gp,
})
