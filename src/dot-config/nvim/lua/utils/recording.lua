vim.g.allow_recoring = false

require("helpers").toggler("allow_recoring", "Recording")

vim.keymap.set("n", "q", function()
  return vim.g.allow_recoring and "q" or "\\<NOP\\>"
end, { expr = true })

vim.api.nvim_create_autocmd("RecordingLeave", {
  group = vim.api.nvim_create_augroup("RecordingAllow", { clear = true }),
  callback = function()
    vim.cmd("RecordingDisable")
  end,
})
