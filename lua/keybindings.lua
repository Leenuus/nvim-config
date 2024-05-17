-- disable keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")
vim.keymap.set({ "n", "v" }, "<BS>", "<Nop>")
vim.keymap.set("n", "gf", "<Nop>")
vim.keymap.set("n", "gq", "<Nop>")
vim.keymap.set("n", "dj", "<Nop>")
vim.keymap.set("n", "dk", "<Nop>")
vim.keymap.set("n", "Q", "<Nop>")

-- resize window
vim.keymap.set("n", "<up>", "<cmd>resize +3<cr>")
vim.keymap.set("n", "<down>", "<cmd>resize -3<cr>")
vim.keymap.set("n", "<left>", "<cmd>vertical resize -3<cr>")
vim.keymap.set("n", "<right>", "<cmd>vertical resize +3<cr>")

-- @diagnostic disable-next-line: undefined-field
if vim.g.neovide then
  -- control + backspace
  vim.keymap.set("i", "<C-BS>", "<c-w>")
  vim.keymap.set("c", "<C-BS>", "<C-w>")
else
  vim.keymap.set("i", "<C-h>", "<c-w>")
  vim.keymap.set("c", "<C-h>", "<C-w>")
end

-- cmdline mode
vim.keymap.set("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })
vim.keymap.set("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })

-- insertion
vim.keymap.set("i", "<c-u>", "<esc>viwUea")
-- navigation
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>zz")
vim.keymap.set("n", "<esc>", "<esc>zz")
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "n", "<cmd>keepjumps normal! nzz<cr>")
vim.keymap.set("n", "N", "<cmd>keepjumps normal! Nzz<cr>")
vim.keymap.set("n", "*", "<cmd>keepjumps normal! *zz<cr>")
vim.keymap.set("n", "#", "<cmd>keepjumps normal! #zz<cr>")
vim.keymap.set("n", "g*", "<cmd>keepjumps normal! g*zz<cr>")
vim.keymap.set("n", "g#", "<cmd>keepjumps normal! g#zz<cr>")
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set({ "n", "v", "o" }, "H", "_")

vim.keymap.set({ "n", "o" }, "L", "$")
vim.keymap.set("v", "L", "$h")

vim.keymap.set({ "n", "v" }, "J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
vim.keymap.set({ "n", "v" }, "K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- quit
vim.keymap.set("n", "<leader>q", "<cmd>x<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>")

-- redo
vim.keymap.set("n", "U", "<cmd>redo<cr>")

-- operators
vim.keymap.set("o", "q", 'i"', { desc = "q double quote" })
vim.keymap.set("o", "Q", 'a"', { desc = "q double quote" })
vim.keymap.set("o", "<HOME>", "i'", { desc = "single quote" })
vim.keymap.set("o", "<END>", "a'", { desc = "single quote" })

-- document existing key chains
require("which-key").register({
  ["<leader>s"] = { name = "Telescope", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "Toggle", _ = "which_key_ignore" },
  ["<leader>l"] = { name = "Lsp", _ = "which_key_ignore" },
})

-- toggle options
vim.keymap.set("n", "<leader>th", "<cmd>set invhlsearch<cr>", { desc = "highlight" })
vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<cr>", { desc = "transparent" })
vim.keymap.set("n", "<leader>tc", "<cmd>set invignorecase<cr>", { desc = "ignorecase" })
vim.keymap.set("n", "<leader>ts", require("helpers").toggle_scrolloff, { desc = "scrolloff" })
vim.keymap.set("n", "<leader>to", "<cmd>ZenMode<cr>", { desc = "ZenMode" })
vim.keymap.set("n", "<leader>tp", "<CMD>InspectTree<CR>", { desc = "Inspect AST Tree" })

-- nmap("<leader>cC", "<cmd>cd %:p:h<cr>", "Change work dir")
vim.keymap.set("n", "<leader>sc", require("telescope.builtin").commands, { desc = "Open Commands" })
vim.keymap.set("n", "<leader>sJ", function()
  require("trouble").toggle()
end, { desc = "Open Trouble" })

-- previous/next
if vim.g.neovide then
  vim.keymap.set("n", "<A-e>", "<cmd>tabNext<cr>", { desc = "next tab" })
  vim.keymap.set("n", "<A-w>", "<cmd>tabclose<cr>", { desc = "close tab" })
  vim.keymap.set("n", "<A-q>", "<cmd>tabprevious<cr>", { desc = "prev tab" })
  vim.keymap.set("n", "<A-t>", "<cmd>tabnew<cr>", { desc = "new tab" })
else
  vim.keymap.set("n", "<leader>'", "<cmd>tabNext<cr>", { desc = "next tab" })
  vim.keymap.set("n", "<leader>;", "<cmd>tabprevious<cr>", { desc = "prev tab" })
end

vim.keymap.set("n", "<leader>w", "<CMD>w<cr>")

-- terminal mode
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "normal mode" })
vim.keymap.set("t", "<leader>q", "<cmd>close<cr>", { desc = "quit" })

-- resession
local resession = require("resession")
vim.keymap.set("n", "<leader>Ss", resession.save_session, { desc = "Save Current Session" })
vim.keymap.set("n", "<leader>sp", resession.restore_session, { desc = "Restore Session" })

-- lsp related keybindings
vim.api.nvim_create_user_command("TSRename", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, { desc = "Rename variable with Treesitter" })
vim.keymap.set("n", "<leader>lr", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, { desc = "Rename Variable With TreeSitter" })
vim.keymap.set("n", "<leader>li", "<CMD>LspInfo<CR>", { desc = "Lsp Info" })

-- lsp related keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.keymap.set({ "n", "v" }, "<leader>la", function()
      vim.lsp.buf.code_action()
    end, { buffer = 0, desc = "Code Action" })
    vim.keymap.set("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, { desc = "Doc Symbols", buffer = 0 })
    vim.keymap.set(
      "n",
      "<leader>lS",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      { desc = "Workspace Symbols" }
    )
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Hover", buffer = 0 })
    vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition", buffer = 0 })
    vim.keymap.set("n", "gD", function()
      vim.lsp.buf.definition()
      vim.cmd([[tabnew %]])
    end, { desc = "Goto Definition", buffer = 0 })
    -- nmap("gD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = 0 })
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "Goto References", buffer = 0 })
    vim.keymap.set(
      "n",
      "gi",
      require("telescope.builtin").lsp_implementations,
      { desc = "Goto Implementation", buffer = 0 }
    )
    vim.keymap.set(
      "n",
      "gt",
      require("telescope.builtin").lsp_type_definitions,
      { desc = "Type Definition", buffer = 0 }
    )

    vim.keymap.set({ "i", "n" }, "<C-P>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", buffer = 0 })
    vim.keymap.set("n", "Q", vim.lsp.buf.format, { desc = "Format Code", buffer = 0 })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename with Lsp", buffer = 0 })
  end,
})

-- TODO: surround things faster
-- nmap('gq', 'ysaw"', 'quote the word')

-- NOTE: go back to previous buffer
-- the latter C-R is
vim.keymap.set("n", "<BS>", "<C-^>", { desc = "quick back to preivous file" })
vim.keymap.set("n", "<C-t>", "<C-^>", { desc = "quick back to preivous file" })
vim.keymap.set("n", "<C-r>", "<C-^>", { desc = "quick back to preivous file" })

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "next buffer" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "previous tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "next tab" })

vim.keymap.set("n", "<leader>at", "<cmd>tabnew %<cr>", { desc = "new tab" })
vim.keymap.set("n", "<leader>al", "<cmd>vnew %<cr>", { desc = "new vertical split" })
vim.keymap.set("n", "<leader>aj", "<cmd>new %<cr>", { desc = "new split" })

vim.keymap.set("n", "]q", function()
  require("trouble").open()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "previous trouble" })

vim.keymap.set("n", "[q", function()
  require("trouble").open()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "next trouble" })

-- NOTE: quick paste
vim.keymap.set("n", "<leader>p", "v$hP", { desc = "quick paste to the end" })
