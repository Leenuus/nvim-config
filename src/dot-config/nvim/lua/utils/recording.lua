vim.g.allow_recoring = false

require("helpers").toggler("allow_recoring", "RecordingAllow")

vim.keymap.set("n", "q", function()
  return vim.g.allow_recoring and "q" or "\\<NOP\\>"
end, { expr = true })
