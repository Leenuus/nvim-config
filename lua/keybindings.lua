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
vim.keymap.set("i", "<c-u>", "<esc>viwUea")
-- EXPORT
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>zz")
-- EXPORT
vim.keymap.set("n", "<esc>", "<esc>zz")
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
vim.keymap.set("n", "<leader>q", "<cmd>x<cr>")
-- EXPORT
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>")

-- EXPORT
vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "redo" })

-- EXPORT
vim.keymap.set("o", "q", 'i"', { desc = "q double quote" })
-- EXPORT
vim.keymap.set("o", "Q", 'a"', { desc = "q double quote" })
-- EXPORT
vim.keymap.set("o", "<HOME>", "i'", { desc = "single quote" })
-- EXPORT
vim.keymap.set("o", "<END>", "a'", { desc = "single quote" })

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
vim.keymap.set("n", "<leader>tc", "<cmd>set invignorecase<cr>", { desc = "ignorecase" })
vim.keymap.set("n", "<leader>ts", require("helpers").toggle_scrolloff, { desc = "scrolloff" })
vim.keymap.set("n", "<leader>to", "<cmd>ZenMode<cr>", { desc = "ZenMode" })
-- EXPORT
vim.keymap.set("n", "<leader>tp", "<CMD>InspectTree<CR>", { desc = "Inspect AST Tree" })

-- nmap("<leader>cC", "<cmd>cd %:p:h<cr>", "Change work dir")
vim.keymap.set("n", "<leader>sc", require("telescope.builtin").commands, { desc = "Open Commands" })
vim.keymap.set("n", "<leader>sJ", function()
  require("trouble").toggle()
end, { desc = "Open Trouble" })

-- previous/next
-- EXPORT
if vim.g.neovide then
  vim.keymap.set("n", "<A-e>", "<cmd>tabNext<cr>", { desc = "next tab" })
  vim.keymap.set("n", "<A-w>", "<cmd>tabclose<cr>", { desc = "close tab" })
  vim.keymap.set("n", "<A-q>", "<cmd>tabprevious<cr>", { desc = "prev tab" })
  vim.keymap.set("n", "<A-t>", "<cmd>tabnew<cr>", { desc = "new tab" })
else
  vim.keymap.set("n", "<leader>'", "<cmd>tabNext<cr>", { desc = "next tab" })
  vim.keymap.set("n", "<leader>;", "<cmd>tabprevious<cr>", { desc = "prev tab" })
end

-- EXPORT
vim.keymap.set("n", "<leader>w", "<CMD>w<cr>")

-- terminal mode
-- EXPORT
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "normal mode" })
-- EXPORT
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
-- EXPORT
vim.keymap.set("n", "<leader>li", "<CMD>LspInfo<CR>", { desc = "Lsp Info" })

-- lsp related keybindings
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

-- EXPORT
vim.keymap.set("n", "<BS>", "<C-^>", { desc = "quick back to preivous file" })
-- EXPORT
vim.keymap.set("n", "<C-t>", "<C-^>", { desc = "quick back to preivous file" })
-- EXPORT
vim.keymap.set("n", "<C-r>", "<C-^>", { desc = "quick back to preivous file" })

-- EXPORT
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "previous buffer" })
-- EXPORT
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "next buffer" })
-- EXPORT
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "previous tab" })
-- EXPORT
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "next tab" })

-- EXPORT
vim.keymap.set("n", "<leader>at", "<cmd>tabnew %<cr>", { desc = "new tab" })
-- EXPORT
vim.keymap.set("n", "<leader>al", "<cmd>vnew %<cr>", { desc = "new vertical split" })
-- EXPORT
vim.keymap.set("n", "<leader>aj", "<cmd>new %<cr>", { desc = "new split" })

vim.keymap.set("n", "]q", function()
  require("trouble").open()
  require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "previous trouble" })

vim.keymap.set("n", "[q", function()
  require("trouble").open()
  require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "next trouble" })

-- EXPORT
vim.keymap.set("n", "<leader>p", "v$hP", { desc = "quick paste to the end" })
