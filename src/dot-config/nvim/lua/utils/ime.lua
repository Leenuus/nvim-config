-- NOTE:
-- a dirty hack that just makes things work
-- no code for edge cases, some furtuher maintenance needed

vim.api.nvim_create_augroup("nvim-ime", { clear = true })

vim.g.ime_enable = false

-- display fcitx state, 0 for close, 1 for inactive, 2 for active
-- local function active_p()
--   local s = vim.system({ "fcitx5-remote" }, {}):wait().stdout
--   return not s == "2\n"
-- end

vim.api.nvim_create_user_command("IMEEnable", function()
  if vim.fn.mode() == "i" then
    vim.system({ "fcitx5-remote", "-o" }, {}):wait()
  end
  vim.g.ime_enable = true
end, { bar = true })

vim.api.nvim_create_user_command("IMEDisable", function()
  vim.system({ "fcitx5-remote", "-c" }, {}):wait()
  vim.g.ime_enable = false
end, { bar = true })

local no_ime_fts = {
  "TelescopePrompt",
}

vim.api.nvim_create_user_command("IMEToggle", function()
  if vim.fn.mode() == "i" then
    vim.system({ "fcitx5-remote", "-t" }, {}):wait()
  end
  vim.g.ime_enable = not vim.g.ime_enable
end, { bar = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if vim.g.ime_enable and not vim.list_contains(no_ime_fts, vim.bo.ft) then
      vim.system({ "fcitx5-remote", "-o" }, {}):wait()
    end
  end,
  group = "nvim-ime",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if vim.g.ime_enable then
      vim.system({ "fcitx5-remote", "-c" }, {}):wait()
    end
  end,
  group = "nvim-ime",
})
