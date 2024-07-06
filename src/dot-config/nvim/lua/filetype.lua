-- EXPORT
vim.filetype.add({
  pattern = {
    ["/tmp/bash%-fc"] = "sh",
    [".*"] = {
      function(path, bufnr)
        local last_line = vim.api.nvim_buf_get_lines(bufnr, -2, -1, false)[1]
        if last_line:match("^# vim:") then
          local filetype = last_line:match("ft=(%a+)")
          return filetype or ""
        end
      end,
      { priority = math.huge },
    },
  },
})

local filetype_mapping = vim.api.nvim_create_augroup("filetype-config", {
  clear = true,
})

-- EXPORT
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("SpellCheck", { clear = true }),
  pattern = { "gitcommit" },
  callback = function()
    vim.wo.spell = true
  end,
})

-- EXPORT
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- EXPORT
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_mapping,
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>x<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<leader>q", "<cmd>x<cr>", { buffer = event.buf, silent = true })
  end,
})

-- EXPORT
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_mapping,
  pattern = {
    "gitcommit",
  },
  callback = function(event)
    vim.keymap.set("n", "<leader>Q", function()
      vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, { "" })
      vim.cmd("x")
    end, { buffer = event.buf, silent = true, desc = "Abort Commit" })
  end,
})
