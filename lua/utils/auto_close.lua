local auto_close_filetype = { "oil", "aerial" }
local auto_close_pat = "conjure%-log"

vim.g.auto_close_enabled = true

vim.api.nvim_create_autocmd({
  "BufEnter",
}, {
  pattern = "*",
  callback = function(ev)
    local is_last = vim.fn.winnr("$") == 1 and vim.fn.tabpagenr("$") == 1
    local is_auto_close_ft = vim.tbl_contains(auto_close_filetype, vim.bo.filetype)
    local is_auto_close_pat = string.find(ev.file, auto_close_pat)
    vim.notify(ev.file)
    if is_last and (is_auto_close_ft or is_auto_close_pat) and vim.g.auto_close_enabled then
      vim.cmd('set guicursor=a:ver90"')
      vim.cmd("x")
    end
  end,
  group = vim.api.nvim_create_augroup("close_if_last", { clear = true }),
})
