-- EXPORT
vim.keymap.set({ "n", "x" }, "<Space>", "<Nop>")
-- EXPORT
vim.keymap.set({ "n", "x" }, "<BS>", "<Nop>")
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
vim.keymap.set({ "n", "x", "o" }, "H", "_")

-- EXPORT
vim.keymap.set({ "n", "o" }, "L", "$")
-- EXPORT
vim.keymap.set("x", "L", "$h")

-- EXPORT
vim.keymap.set("x", "<", "<gv")
-- EXPORT
vim.keymap.set("x", ">", ">gv")

-- EXPORT
vim.keymap.set("n", "<leader>w", function()
  if vim.bo.bufhidden == "hide" or vim.bo.buftype == "nofile" or not vim.o.swapfile then
    return "\\<NOP\\>"
  else
    return "<CMD>w<CR>"
  end
end, { expr = true })
-- EXPORT
vim.keymap.set("n", "<leader>ww", "<cmd>wall<cr>")
-- EXPORT
vim.keymap.set("n", "<leader>q", "<cmd>x<cr>", { desc = "safe quit" })
-- EXPORT
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>", { desc = "force quit" })
-- EXPORT
vim.keymap.set("n", "<leader>qq", "<cmd>xall<cr>", { desc = "safe quit all" })

-- EXPORT
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "redo" })

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
    vim.keymap.set({ "n", "x" }, "<leader>la", function()
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
vim.keymap.set("n", "<C-r>", "<C-^>", { desc = "quick back to previous file" })

-- EXPORT
vim.keymap.set("n", "<leader>ke", "<cmd>bprevious<cr>", { desc = "previous buffer" })
-- EXPORT
vim.keymap.set("n", "<leader>je", "<cmd>bnext<cr>", { desc = "next buffer" })
-- EXPORT
vim.keymap.set("n", "<leader>kw", "<cmd>tabprevious<cr>", { desc = "previous tab" })
-- EXPORT
vim.keymap.set("n", "<leader>jw", "<cmd>tabnext<cr>", { desc = "next tab" })

-- EXPORT
vim.keymap.set("n", "<leader>ap", "<cmd>tabnew %<cr>", { desc = "new tab" })
-- EXPORT
vim.keymap.set("n", "<leader>aP", function()
  vim.cmd("tabnew")
  vim.opt_local.bufhidden = "hide"
  vim.opt_local.buftype = "nofile"
  vim.opt_local.swapfile = false
end, { desc = "new scratch tab" })
-- EXPORT
vim.keymap.set("n", "<leader>ah", function()
  vim.api.nvim_open_win(0, false, { win = 0, split = "left" })
end, { desc = "split left" })
-- EXPORT
vim.keymap.set("n", "<leader>al", "<CMD>vsplit #<CR>", { desc = "split alternate buffer right" })
vim.keymap.set("n", "<leader>aL", "<CMD>vnew<CR>", { desc = "split right" })
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
vim.keymap.set("n", "<leader>sj", function()
  require("telescope.builtin").jumplist()
end, { desc = "Jump list" })
vim.keymap.set("n", "<leader>sH", function()
  require("telescope.builtin").command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope colorscheme<cr>", { desc = "search colorscheme" })
vim.keymap.set("n", "<leader>sc", function()
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

vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").resume()
end, { desc = "Resume telescope" })
vim.keymap.set("n", "<leader>sl", function()
  require("telescope.builtin").resume()
end, { desc = "Resume telescope" })
vim.keymap.set("n", "<leader>sh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Find Helps" })
vim.keymap.set("n", "<leader>sO", function()
  require("telescope.builtin").vim_options()
end, { desc = "Find Options" })
vim.keymap.set("n", "<leader>so", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Find Recent Files" })
vim.keymap.set("n", "<leader>sm", function()
  require("telescope.builtin").man_pages({ sections = { "ALL" } })
end, { desc = "Find man pages" })
vim.keymap.set("n", "<leader>ss", function()
  require("telescope.builtin").builtin()
end, { desc = "Show telescopes" })

vim.keymap.set("n", "<leader>td", "<CMD>tabnew +vertical\\ DBUI<CR>", { desc = "Open Database UI" })

vim.keymap.set("n", "<leader>te", "<CMD>MiniFiles<CR>", { desc = "Open File Manager" })

vim.keymap.set("n", "<leader>tm", "<CMD>Mes<CR>", { desc = "Open messages in split window" })

-- EXPORT
vim.keymap.set("n", "\\", "/\\<\\><left><left>", { desc = "search whole word" })
vim.keymap.set("n", "<leader>sp", "<CMD>Telescope project<CR>", { desc = "Browse Projects" })

vim.keymap.set("n", "<leader>tP", function()
  local ft = vim.bo.ft
  if ft == "sh" then
    ft = "bash"
  end
  local cmd = string.format("vnew %s/after/ftplugin/%s.lua", vim.fn.stdpath("config"), ft)
  vim.cmd(cmd)
end, { desc = "open filetype plugin" })

vim.keymap.set("n", "<leader>sp", "<CMD>Telescope project<CR>", { desc = "open projects" })

-- NOTE: when recording, use normal j and k, but most of time, I would like gj and gk
-- EXPORT
vim.keymap.set({ "n", "x" }, "k", function()
  if vim.g.allow_recoring then
    return "k"
  else
    return "gk"
  end
end, { expr = true })
-- EXPORT
vim.keymap.set({ "n", "x" }, "j", function()
  if vim.g.allow_recoring then
    return "j"
  else
    return "gj"
  end
end, { expr = true })

-- NOTE: vim-surround is amazing
vim.keymap.set("x", "gs", "<Plug>VSurround", { desc = "add surround" })
vim.keymap.set("x", "gS", "<Plug>VgSurround", { desc = "add surround" })
vim.keymap.set("i", "<C-f>", "<CMD>MiniPairToggle<CR>", { desc = "toggle insert pair" })
vim.keymap.set("i", "<C-g>", "<Plug>ISurround", { desc = "insert pair and new lines" })

vim.keymap.set("n", "cgs", "<Plug>Csurround", { desc = "change surround" })
vim.keymap.set("n", "cgS", "<Plug>CSurround", { desc = "change surround" })
vim.keymap.set("n", "dgs", "<Plug>Dsurround", { desc = "delete surround" })
vim.keymap.set("n", "dgS", "<Plug>DsurroundiW", { desc = "delete surround" })
vim.keymap.set("n", "gs", "<Plug>Ysurround", { desc = "add surround" })
vim.keymap.set("n", "gS", "<Plug>YsurroundiW", { desc = "surround current word" })

-- NOTE: better marks
-- EXPORT
vim.keymap.set("n", "m", function()
  local m_char = vim.fn.getchar()
  local group = "mark"

  if (m_char >= 97 and m_char < 97 + 26) or (m_char >= 65 and m_char < 65 + 26) then
    local name = string.char(m_char)
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    vim.api.nvim_buf_set_mark(0, name, line, col, {})
    local buf = vim.fn.bufnr()

    local s_name = "mark" .. name

    -- delete if exists
    local sign_list = vim.fn.sign_getplaced(buf, { group = group })[1].signs
    for _, s in ipairs(sign_list) do
      if s.name == s_name then
        vim.fn.sign_unplace(group, { buffer = buf, id = s.id })
      end
    end

    vim.fn.sign_define(s_name, { text = name })
    vim.fn.sign_place(0, group, s_name, buf, { lnum = line })
  else
    return
  end
end, { desc = "Simple Better Mark" })

vim.keymap.set("n", "<leader>sM", "<CMD>Mes<CR>", { desc = "Open Messages in split" })

vim.keymap.set("n", "<leader>sg", "<cmd>LiveGrep<cr>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>sF", "<cmd>FindFilesMode<cr>", { desc = "Select Search Mode" })
vim.keymap.set("n", "<leader>sf", "<cmd>FindFiles %:p:h<cr>", { desc = "Select Search Mode" })
vim.keymap.set("n", "<leader><space>", "<cmd>FindFiles<cr>")

-- EXPORT
vim.keymap.set("x", "'", "gc", { desc = "toggle comment", remap = true })
vim.keymap.set("n", "g'", "gcc", { desc = "toggle line comment", remap = true })

vim.keymap.set("n", "<leader>sb", function()
  require("telescope.builtin").buffers()
end, { desc = "search buffers" })

-- Ctrl-E to go back to last window
-- EXPORT
vim.keymap.set("n", "<C-E>", "<CMD>wincmd p<CR>", { desc = "previous window" })

-- EXPORT
vim.keymap.set("n", "<leader>cd", "<CMD>lcd %:h | pwd<CR>", { desc = "lcd cfd" })
-- EXPORT
vim.keymap.set("n", "<leader>cc", "<CMD>lcd .. | pwd<CR>", { desc = "lcd parent dir" })
vim.keymap.set("n", "<leader>cg", "<CMD>GitRootCd | pwd<CR>", { desc = "lcd gitroot" })

-- fugitive
vim.keymap.set("n", "<leader>gg", "<CMD>SplitLeft Git<CR>", { desc = "Awesome Git Wrapper" })
vim.keymap.set("n", "<leader>gl", "<CMD>Tmux lazygit<CR>", { desc = "Quick Lazygit" })

-- insert completion
vim.keymap.set("i", "<C-L>", "<C-X>", { desc = "more egnostic C-X" })

-- in document
-- EXPORT
vim.keymap.set("x", "id", ":<C-U>normal! ggVG<CR>", { desc = "in document" })
-- EXPORT
vim.keymap.set("o", "id", ":<C-U>normal! ggVG<CR>", { desc = "in document" })

vim.keymap.set("n", "<leader>el", "<CMD>EvalLine<CR>", { desc = "evaluate line" })
vim.keymap.set("n", "<leader>ee", "<CMD>EvalFile<CR>", { desc = "evaluate file" })
vim.keymap.set("n", "<leader>ef", "<CMD>EvalFile<CR>", { desc = "evaluate file" })
vim.keymap.set("x", "<leader><CR>", "<CMD>EvalRange!<CR>", { desc = "evaluate range, collect stderr" })
vim.keymap.set("x", "<CR>", "<CMD>EvalRange<CR>", { desc = "evaluate range" })

-- Redir powered keymaps
-- my nerdtree
vim.keymap.set("n", "<leader>tE", function()
  return "<CMD>SplitLeft Redir !tree --gitignore " .. vim.fn.getcwd(0) .. "<CR>"
end, { desc = "Open Tree View", expr = true })

vim.keymap.set("i", "<C-Q>", "<CMD>IMEToggle<CR>", { desc = "Toggle Input method" })

vim.keymap.set("n", "<leader>sp", "<CMD>FindProjects<CR>", { desc = "Open Common Used Projects" })

-- target.vim
vim.keymap.set("n", "c'", "ciq", { desc = "change inside quote", remap = true })
vim.keymap.set("n", "d'", "diq", { desc = "delete inside quote", remap = true })
vim.keymap.set("n", 'c"', "caq", { desc = "change around quote", remap = true })
vim.keymap.set("n", 'd"', "daq", { desc = "delete around quote", remap = true })
vim.keymap.set("n", "y'", "yiq", { desc = "yank inside quote", remap = true })
vim.keymap.set("n", 'y"', "yaq", { desc = "yank around quote", remap = true })

-- EXPORT
vim.keymap.set({ "n", "x" }, "J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
-- EXPORT
vim.keymap.set({ "n", "x" }, "K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')

-- EXPORT
vim.keymap.set("n", "ce", function()
  local w = vim.fn.expand("<cword>")
  -- print(vim.inspect(w))
  if #w == 1 then
    return "cl"
  else
    return "ce"
  end
end, { expr = true })

-- EXPORT
vim.keymap.set("n", "de", function()
  local w = vim.fn.expand("<cword>")
  -- print(vim.inspect(w))
  if #w == 1 then
    return "dl"
  else
    return "de"
  end
end, { expr = true })

vim.keymap.set("n", "<leader>fs", "<CMD>set ft=sh<CR>", { desc = "filetype sh" })

-- EXPORT
vim.keymap.set("n", "cc", "_C", { desc = "better cc" })
