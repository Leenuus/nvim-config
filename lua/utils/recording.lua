vim.g.allow_recoring = false

local function toggle_allow_recording()
  vim.g.allow_recoring = not vim.v.allow_recoring
end

local function enable_recording()
  vim.g.allow_recoring = true
end

local function disable_recording()
  vim.g.allow_recoring = false
end

vim.keymap.set("n", "q", function()
  return vim.g.allow_recoring and "q" or "\\<NOP\\>"
end, { expr = true })
vim.api.nvim_create_user_command("RecordingAllowEnable", enable_recording, {})
vim.api.nvim_create_user_command("RecordingAllowDisable", disable_recording, {})
vim.api.nvim_create_user_command("RecordingAllowToggle", toggle_allow_recording, {})
