-- EXPORT
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")
-- EXPORT
vim.keymap.set({ "n", "v" }, "<BS>", "<Nop>")
-- EXPORT
vim.keymap.set("n", "gf", "<Nop>")
-- EXPORT
vim.keymap.set("n", "gq", "<Nop>")
-- EXPORT
vim.keymap.set("n", "dj", "<Nop>")
-- EXPORT
vim.keymap.set("n", "dk", "<Nop>")
-- EXPORT
vim.keymap.set("n", "Q", "<Nop>")

-- EXPORT
vim.keymap.set("n", "<up>", "<cmd>resize +3<cr>")
-- EXPORT
vim.keymap.set("n", "<down>", "<cmd>resize -3<cr>")
-- EXPORT
vim.keymap.set("n", "<left>", "<cmd>vertical resize -3<cr>")
-- EXPORT
vim.keymap.set("n", "<right>", "<cmd>vertical resize +3<cr>")

-- EXPORT
if vim.g.neovide then
  -- control + backspace
  vim.keymap.set("i", "<C-BS>", "<c-w>")
  vim.keymap.set("c", "<C-BS>", "<C-w>")
else
  vim.keymap.set("i", "<C-h>", "<c-w>")
  vim.keymap.set("c", "<C-h>", "<C-w>")
end

-- EXPORT
vim.keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })
-- EXPORT
vim.keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })

-- EXPORT
vim.keymap.set("i", "<ESC>", "<esc>zz")
-- EXPORT
vim.keymap.set("i", "<c-u>", "<esc>viwUea")
-- EXPORT
vim.keymap.set("n", "<ESC>", "<cmd>noh<cr><esc>zz")
-- EXPORT
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- EXPORT
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- EXPORT
vim.keymap.set("n", "n", "<cmd>keepjumps normal! nzz<cr>")
-- EXPORT
vim.keymap.set("n", "N", "<cmd>keepjumps normal! Nzz<cr>")
-- EXPORT
vim.keymap.set("n", "*", "<cmd>keepjumps normal! *zz<cr>")
-- EXPORT
vim.keymap.set("n", "#", "<cmd>keepjumps normal! #zz<cr>")
-- EXPORT
vim.keymap.set("n", "g*", "<cmd>keepjumps normal! g*zz<cr>")
-- EXPORT
vim.keymap.set("n", "g#", "<cmd>keepjumps normal! g#zz<cr>")
-- EXPORT
vim.keymap.set("x", "p", [["_dP]])
-- EXPORT
vim.keymap.set({ "n", "v", "o" }, "H", "_")

-- EXPORT
vim.keymap.set({ "n", "o" }, "L", "$")
-- EXPORT
vim.keymap.set("v", "L", "$h")

-- EXPORT
vim.keymap.set({ "n", "v" }, "J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
-- EXPORT
vim.keymap.set({ "n", "v" }, "K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')

-- EXPORT
vim.keymap.set("v", "<", "<gv")
-- EXPORT
vim.keymap.set("v", ">", ">gv")

-- EXPORT
vim.keymap.set("n", "<leader>w", '<cmd>w<cr>')
-- EXPORT
vim.keymap.set("n", "<leader>q", "<cmd>x<cr>", { desc = 'safe quit' })
-- EXPORT
vim.keymap.set("n", "<leader>qp", "<cmd>q!<cr>", { desc = 'force quit' })
-- EXPORT
vim.keymap.set("n", "<leader>qq", "<cmd>xall<cr>", { desc = 'safe quit all' })

-- EXPORT
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "redo" })

-- document existing key chains
require("which-key").register({
  ["<leader>s"] = { name = "Telescope", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "Toggle", _ = "which_key_ignore" },
  ["<leader>l"] = { name = "Lsp", _ = "which_key_ignore" },
})

-- toggle options
-- EXPORT
vim.keymap.set("n", "<leader>th", "<cmd>set invhlsearch<cr>", { desc = "highlight" })
vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<cr>", { desc = "transparent" })
-- EXPORT
vim.keymap.set("n", "<leader>tC", "<cmd>set invignorecase<cr>", { desc = "ignorecase" })
vim.keymap.set("n", "<leader>to", "<cmd>AerialToggle! left<cr>", { desc = "Outline" })
-- EXPORT
vim.keymap.set("n", "<leader>tp", "<CMD>InspectTree<CR>", { desc = "Inspect AST Tree" })
vim.keymap.set("n", "<leader>tc", "<CMD>TSContextToggle<CR>", { desc = "Toggle Treesitter Context" })

vim.keymap.set("n", "<leader>\\", function()
  require("telescope.builtin").commands(require("telescope.themes").get_ivy({
    winblend = 20,
  }))
end, { desc = "Open Commands" })

vim.keymap.set("n", "<leader>sJ", function()
  require("trouble").toggle()
end, { desc = "Open Trouble" })

-- previous/next
-- EXPORT
if vim.g.neovide then
  vim.keymap.set("n", "<A-w>", "<cmd>tabclose<cr>", { desc = "close tab" })
  vim.keymap.set("n", "<A-t>", "<cmd>tabnew<cr>", { desc = "new tab" })
  vim.keymap.set("n", "<A-q>;", "gT", { desc = "prev tab" })
  vim.keymap.set("n", "<A-e>'", "gt", { desc = "next tab" })
else
  vim.keymap.set("n", "<leader>;", "gT", { desc = "prev tab" })
  vim.keymap.set("n", "<leader>'", "gt", { desc = "next tab" })
end


-- terminal mode
-- EXPORT
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "normal mode" })
-- EXPORT
vim.keymap.set("t", "<leader>q", "<cmd>x<cr>", { desc = "quit" })

-- lsp related keybindings
vim.api.nvim_create_user_command("TSRename", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, { desc = "Rename variable with Treesitter" })
vim.keymap.set("n", "<leader>lr", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, { desc = "Rename Variable With TreeSitter" })
-- EXPORT
vim.keymap.set("n", "<leader>li", "<CMD>LspInfo<CR>", { desc = "Lsp Info" })
-- EXPORT
vim.keymap.set("n", "<leader>lR", "<CMD>LspRestart<CR>", { desc = "Lsp Restart" })
-- EXPORT
vim.keymap.set("n", "gH", vim.diagnostic.open_float, { desc = "diagnostic in float" })

-- lsp related keybindings
-- EXPORT
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set({ "n", "v" }, "<leader>la", function()
      vim.lsp.buf.code_action()
    end, { buffer = 0, desc = "Code Action" })

    vim.keymap.set(
      "n",
      "<leader>ls",
      require("telescope.builtin").lsp_document_symbols,
      { desc = "Doc Symbols", buffer = 0 }
    )

    vim.keymap.set(
      "n",
      "<leader>lS",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      { desc = "Workspace Symbols" }
    )
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Hover", buffer = 0 })

    vim.keymap.set("n", "gd", function()
      local ok, _ = pcall(require("telescope.builtin").lsp_definitions)
      if not ok then
        vim.lsp.buf.definition()
      end
    end, { desc = "Goto Definition", buffer = 0 })

    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.definition()
      vim.cmd([[tabnew %]])
    end, { desc = "Goto Definition", buffer = 0 })

    vim.keymap.set("n", "gr", function()
      local ok, _ = pcall(require("telescope.builtin").lsp_references)
      if not ok then
        vim.lsp.buf.references()
      end
    end, { desc = "Goto References", buffer = 0 })

    vim.keymap.set("n", "gi", function()
      local ok, _ = pcall(require("telescope.builtin").lsp_implementations)
      if not ok then
        vim.lsp.buf.implementation()
      end
    end, { desc = "Goto Implementation", buffer = 0 })

    vim.keymap.set("n", "gt", function()
      local ok, _ = pcall(require("telescope.builtin").lsp_type_definitions)
      if not ok then
        vim.lsp.buf.type_definition()
      end
    end, { desc = "Type Definition", buffer = 0 })

    vim.keymap.set({ "i", "n" }, "<C-P>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", buffer = 0 })
    vim.keymap.set("n", "Q", vim.lsp.buf.format, { desc = "Format Code", buffer = 0 })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename with Lsp", buffer = 0 })
  end,
})

-- EXPORT
vim.keymap.set("n", "<BS>", "<C-^>", { desc = "quick back to previous file" })
-- EXPORT
vim.keymap.set("n", "<C-t>", "<C-^>", { desc = "quick back to previous file" })
-- EXPORT
vim.keymap.set("n", "<C-r>", "<C-^>", { desc = "quick back to previous file" })

-- EXPORT
vim.keymap.set("n", "<leader>kb", "<cmd>bprevious<cr>", { desc = "previous buffer" })
-- EXPORT
vim.keymap.set("n", "<leader>jb", "<cmd>bnext<cr>", { desc = "next buffer" })
-- EXPORT
vim.keymap.set("n", "<leader>kt", "<cmd>tabprevious<cr>", { desc = "previous tab" })
-- EXPORT
vim.keymap.set("n", "<leader>jt", "<cmd>tabnext<cr>", { desc = "next tab" })

-- EXPORT
vim.keymap.set("n", "<leader>at", "<cmd>tabnew %<cr>", { desc = "new tab" })
-- EXPORT
vim.keymap.set("n", "<leader>ah", function()
  vim.api.nvim_open_win(0, false, { win = 0, split = "left" })
end, { desc = "split left" })
-- EXPORT
vim.keymap.set("n", "<leader>al", function()
  vim.api.nvim_open_win(0, false, { win = 0, split = "right" })
end, { desc = "split right" })
-- EXPORT
vim.keymap.set("n", "<leader>aj", function()
  vim.api.nvim_open_win(0, false, { win = 0, split = "below" })
end, { desc = "split below" })
-- EXPORT
vim.keymap.set("n", "<leader>ak", function()
  vim.api.nvim_open_win(0, false, { win = 0, split = "above" })
end, { desc = "split above" })
-- EXPORT
vim.keymap.set("n", "<leader>aK", function()
  local height = math.floor(vim.api.nvim_win_get_height(0) / 3)
  return string.format("<CMD>aboveleft %dnew +term<CR>i", height)
end, { desc = "split terminal above", expr = true })
-- EXPORT
vim.keymap.set("n", "<leader>aJ", function()
  local height = math.floor(vim.api.nvim_win_get_height(0) / 3)
  return string.format("<CMD>%dnew +term<CR>i", height)
end, { desc = "split terminal below", expr = true })

vim.keymap.set("n", "<leader>jq", function()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "previous trouble" })

vim.keymap.set("n", "<leader>kq", function()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "next trouble" })

-- EXPORT
vim.keymap.set("n", "<leader>p", "v$hP", { desc = "quick paste to the end" })

-- NOTE: better gx
-- EXPORT
vim.keymap.set("n", "gx", function()
  local c = vim.fn.expand("<cfile>")
  if string.match(c, "^%.") or string.match(c, "^/") or string.match(c, "~") then
    local res = vim.fn.system("file " .. c)
    if res:match("ASCII text") or res:match("Unicode text") then
      vim.cmd["vnew"](c)
    elseif res:match("directory") then
    else
      vim.ui.open(c)
    end
  elseif string.match(c, "^https?://") then
    vim.ui.open(c)
  else
    vim.notify(c .. " :`gx` do nothing!")
  end
end, { desc = "open things under cursor" })

-- EXPORT
vim.keymap.set("n", "<C-F>", "<C-Q>", { desc = "egnostic vblock mode" })

-- NOTE: open snippets
vim.keymap.set("n", "<leader>tT", function()
  local ft = vim.bo.ft
  if ft == "sh" then
    ft = "bash"
  end
  local cmd = string.format("vnew %s/lua/snippets/%s.lua", vim.fn.stdpath("config"), ft)
  vim.cmd(cmd)
end, { desc = "open snippet" })

-- NOTE: telescope
vim.keymap.set("n", "<leader>sj", require("telescope.builtin").jumplist, { desc = "Jump list" })
vim.keymap.set("n", "<leader>sH", require("telescope.builtin").command_history, { desc = "Command History" })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope colorscheme<cr>", { desc = "search colorscheme" })
vim.keymap.set("n", "<leader>sm", "<cmd>messages<cr>", { desc = "search for messages" })
vim.keymap.set("n", "<leader>sC", function()
  vim.cmd("Telescope registers")
end, { desc = "Search Clipboard" })
vim.keymap.set("n", "<leader>s/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
    winblend = 10,
  }))
end, { desc = "Search Current buffer" })
vim.keymap.set("n", "<leader>sk", function()
  require("telescope.builtin").keymaps(require("telescope.themes").get_ivy({
    winblend = 20,
  }))
end, { desc = "Show Keymaps" })

vim.keymap.set("n", "<leader>/", require("telescope.builtin").resume, { desc = "Resume telescope" })
vim.keymap.set("n", "<leader>sl", require("telescope.builtin").resume, { desc = "Resume telescope" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Find Helps" })
vim.keymap.set("n", "<leader>sM", function()
  require("telescope.builtin").man_pages({ sections = { "ALL" } })
end, { desc = "Find man pages" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "Show telescopes" })
vim.keymap.set("n", "<leader>sg", "<cmd>GrepGitRoot<cr>", { desc = "Grep Git root" })
vim.keymap.set("n", "<leader>sG", "<cmd>GrepCwd<cr>", { desc = "Grep current File dir" })

vim.keymap.set('n', '<leader>td', '<CMD>tabnew +vertical\\ DBUI<CR>', { desc = 'Open Database UI' } )


vim.keymap.set("n", "<leader><space>", "<cmd>QuickFiles<cr>")
vim.keymap.set("n", "<leader>sf", "<cmd>FindFiles<cr>")
vim.keymap.set("n", "<leader>sF", "<cmd>SearchMode<cr>", { desc = "Select Search Mode" })

vim.keymap.set("n", "<leader>te", "<CMD>MiniFiles<CR>", { desc = "Open File Manager" })
