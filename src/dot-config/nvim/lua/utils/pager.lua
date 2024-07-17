vim.api.nvim_create_autocmd("StdinReadPost", {
  callback = function(e)
    if vim.env["nvimpager"] == "1" then
      vim.bo[e.buf].readonly = true
      vim.bo[e.buf].buftype = "nofile"
      vim.bo[e.buf].bufhidden = "hide"
      vim.bo[e.buf].swapfile = false
      vim.b["nvimpager"] = true
      vim.keymap.set('n', 'q', '<CMD>x<CR>', { desc = 'quit', buffer = 0 })
    end
  end,
})
