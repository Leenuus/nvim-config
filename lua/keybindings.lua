local helpers = require("helpers")
local imap = helpers.map_insert
local nmap = helpers.map_normal
local tmap = helpers.map_toggle
local vmap = helpers.map_visual
local omap = helpers.map_operator
local cmap = helpers.map_command
local lmap = helpers.map_leader
local map_terminal = helpers.map_terminal

local map = helpers.map

-- disable keymaps
map({ "n", "v" }, "<Space>", "<Nop>")
map({ "n", "v" }, "<BS>", "<Nop>")
nmap("gf", "<Nop>")
nmap("gq", "<Nop>")
nmap("dj", "<Nop>")
nmap("dk", "<Nop>")
nmap("Q", "<Nop>")

-- resize window
nmap("<up>", "<cmd>resize +3<cr>")
nmap("<down>", "<cmd>resize -3<cr>")
nmap("<left>", "<cmd>vertical resize -3<cr>")
nmap("<right>", "<cmd>vertical resize +3<cr>")

-- @diagnostic disable-next-line: undefined-field
if vim.g.neovide then
  -- control + backspace
  imap("<C-BS>", "<c-w>")
  cmap("<C-BS>", "<C-w>")
else
  imap("<C-h>", "<c-w>")
  cmap("<C-h>", "<C-w>")
end

-- cmdline mode
cmap("<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })
cmap("<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })

-- insertion
imap("<c-u>", "<esc>viwUea")
-- navigation
nmap("<esc>", "<cmd>noh<cr><esc>zz")
imap("<esc>", "<esc>zz")
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
nmap("n", "<cmd>keepjumps normal! nzz<cr>")
nmap("N", "<cmd>keepjumps normal! Nzz<cr>")
nmap("*", "<cmd>keepjumps normal! *zz<cr>")
nmap("#", "<cmd>keepjumps normal! #zz<cr>")
nmap("g*", "<cmd>keepjumps normal! g*zz<cr>")
nmap("g#", "<cmd>keepjumps normal! g#zz<cr>")
map("x", "p", [["_dP]])

map({ "n", "v", "o" }, "H", "_")

map({ "n", "o" }, "L", "$")
vmap("L", "$h")

map({ "n", "v" }, "J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
map({ "n", "v" }, "K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')

vmap("<", "<gv")
vmap(">", ">gv")

-- quit
nmap("<leader>q", "<cmd>x<cr>")
nmap("<leader>Q", "<cmd>q!<cr>")

-- redo
nmap("U", "<cmd>redo<cr>")

-- operators
omap("q", 'i"', "q double quote")
omap("Q", 'a"', "q double quote")
omap("<HOME>", "i'", "single quote")
omap("<END>", "a'", "single quote")

-- document existing key chains
require("which-key").register({
  ["<leader>s"] = { name = "Telescope", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "Toggle", _ = "which_key_ignore" },
  ["<leader>l"] = { name = "Lsp", _ = "which_key_ignore" },
})

-- toggle options
tmap("h", "<cmd>set invhlsearch<cr>", "highlight")
tmap("t", "<cmd>TransparentToggle<cr>", "transparent")
tmap("c", "<cmd>set invignorecase<cr>", "ignorecase")
tmap("s", helpers.toggle_scrolloff, "scrolloff")
tmap("o", "<cmd>ZenMode<cr>", "ZenMode")
tmap("p", "<CMD>InspectTree<CR>", "Inspect AST Tree")

-- nmap("<leader>cC", "<cmd>cd %:p:h<cr>", "Change work dir")
nmap("<leader>sc", require("telescope.builtin").commands, "Commands")
nmap("<leader>sJ", function()
  require("trouble").toggle()
end, "Commands")

-- previous/next
if vim.g.neovide then
  nmap("<A-e>", "<cmd>tabNext<cr>", "next tab")
  nmap("<A-w>", "<cmd>tabclose<cr>", "close tab")
  nmap("<A-q>", "<cmd>tabprevious<cr>", "prev tab")
  nmap("<A-t>", "<cmd>tabnew<cr>", "new tab")
else
  lmap("'", "<cmd>tabNext<cr>", "next tab")
  lmap(";", "<cmd>tabprevious<cr>", "prev tab")
end

nmap("<leader>w", "<CMD>w<cr>")

-- terminal mode
map_terminal("<esc>", [[<C-\><C-n>]], "normal mode")
map_terminal("<leader>q", "<cmd>close<cr>", "quit")

-- resession
local resession = require("resession")
lmap("Ss", resession.save_session, "Save Current Session")
lmap("sp", resession.restore_session, "Restore Session")

-- lsp related keybindings
vim.api.nvim_create_user_command("TSRename", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, { desc = "Rename variable with Treesitter" })
lmap("lr", function()
  require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
end, "Rename Variable With TreeSitter")
lmap("li", "<CMD>LspInfo<CR>")

-- lsp related keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    map({ "n", "v" }, "<leader>la", function()
      vim.lsp.buf.code_action()
    end, { buffer = 0, desc = "Code Action" })
    lmap("ls", require("telescope.builtin").lsp_document_symbols, { desc = "Doc Symbols", buffer = 0 })
    lmap("lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
    nmap("gh", vim.lsp.buf.hover, { desc = "Hover", buffer = 0 })
    nmap("gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition", buffer = 0 })
    nmap("gD", function()
      vim.lsp.buf.definition()
      vim.cmd([[tabnew %]])
    end, { desc = "Goto Definition", buffer = 0 })
    -- nmap("gD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = 0 })
    nmap("gr", require("telescope.builtin").lsp_references, { desc = "Goto References", buffer = 0 })
    nmap("gi", require("telescope.builtin").lsp_implementations, { desc = "Goto Implementation", buffer = 0 })
    nmap("gt", require("telescope.builtin").lsp_type_definitions, { desc = "Type Definition", buffer = 0 })

    map({ "i", "n" }, "<C-P>", vim.lsp.buf.signature_help, { desc = "Signature Documentation", buffer = 0 })
    nmap("Q", vim.lsp.buf.format, { desc = "Format Code", buffer = 0 })
    lmap("lr", vim.lsp.buf.rename, { desc = "Rename with Lsp", buffer = 0 })
  end,
})

-- TODO: surround things faster
-- nmap('gq', 'ysaw"', 'quote the word')

-- NOTE: go back to previous buffer
-- the latter C-R is much easier to press than C-T, so map it
nmap("<C-t>", "<C-^>", "quick back to preivous file")
nmap("<C-r>", "<C-^>", "quick back to preivous file")

nmap("[b", "<cmd>bprevious<cr>", "previous buffer")
nmap("]b", "<cmd>bnext<cr>", "next buffer")
nmap("[t", "<cmd>tabprevious<cr>", "previous tab")
nmap("]t", "<cmd>tabnext<cr>", "next tab")

lmap("at", "<cmd>tabnew %<cr>", "new tab")
lmap("al", "<cmd>vnew %<cr>", "new vertical split")
lmap("aj", "<cmd>new %<cr>", "new split")

nmap("]q", function()
  require("trouble").open()
  require("trouble").next({ skip_groups = true, jump = true })
end, "previous trouble")

nmap("[q", function()
  require("trouble").open()
  require("trouble").previous({ skip_groups = true, jump = true })
end, "next trouble")

-- NOTE: quick paste
lmap("p", "v$hP", "quick paste to the end")
