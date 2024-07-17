-- EXPORT
vim.g.auto_close_filetype = { "aerial" }

-- EXPORT
vim.g.auto_close_enabled = true

-- EXPORT
vim.api.nvim_create_autocmd({
  "BufEnter",
}, {
  pattern = "*",
  callback = function()
    local is_last = vim.fn.winnr("$") == 1 and vim.fn.tabpagenr("$") == 1

    local is_auto_close_ft = vim.tbl_contains(vim.g.auto_close_filetype, vim.bo.filetype)

    local is_scratch_file = vim.bo.bufhidden == "hide" and vim.o.buftype == "nofile" and not vim.o.swapfile

    local is_pager = vim.b["nvimpager"]

    if not is_pager and is_last and (is_auto_close_ft or is_scratch_file) and vim.g.auto_close_enabled then
      vim.cmd('set guicursor=a:ver90"')
      vim.cmd("x")
    end
  end,
  group = vim.api.nvim_create_augroup("close_if_last", { clear = true }),
})
