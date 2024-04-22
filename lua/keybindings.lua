local helpers = require("helpers")
local imap = helpers.map_insert
local nmap = helpers.map_normal
local tmap = helpers.map_toggle
local vmap = helpers.map_visual
local omap = helpers.map_operator
local cmap = helpers.map_command
local lmap = helpers.map_leader
local map = helpers.map

-- disable keymaps
map({ "n", "v" }, "<Space>", "<Nop>")
nmap("gf", "<Nop>")

-- jump around windows
map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>")
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>")
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>")
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>")

-- resize window
nmap("<up>", "<cmd>resize +3<cr>")
nmap("<down>", "<cmd>resize -3<cr>")
nmap("<left>", "<cmd>vertical resize -3<cr>")
nmap("<right>", "<cmd>vertical resize +3<cr>")

-- split window
nmap("<c-\\>", "<cmd>vnew<cr>")
nmap("<c-s>", "<cmd>new<cr>")

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
map({ "i", "s" }, "<C-]>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- navigation
nmap("<esc>", "<cmd>noh<cr><esc>zz")
imap("<esc>", "<esc>zz<cmd>noh<cr>")
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
nmap("n", "nzz")
nmap("N", "Nzz")
nmap("*", "*zz")
nmap("#", "#zz")
nmap("g*", "g*zz")
nmap("g#", "g#zz")
map("x", "p", [["_dP]])

map({ "n", "v", "o" }, "H", "_")

map({ "n", "o" }, "L", "$")
vmap("L", "$h")

map({ "n", "v" }, "J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
map({ "n", "v" }, "K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')

vmap("<", "<gv")
vmap(">", ">gv")

-- quit
nmap("<leader>q", function()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    -- @diagnostic disable-next-line: assign-type-mismatch
    local ok, _ = pcall(vim.cmd, "close")
    if not ok then
      vim.cmd("x")
    end
  else
    vim.cmd("x")
  end
end)
nmap("<leader>Q", "<cmd>q!<cr>")

-- redo
nmap("U", "<cmd>redo<cr>")

-- operators
omap("q", "i(", "<q> parenthesis")
omap("Q", "a(", "<q> parenthesis")
omap("k", "i'", "<k> single quote")
omap("K", "a'", "<k> single quote")
omap("j", 'i"', "<j> double quotes")
omap("J", 'a"', "<j> double quotes")
omap("h", "i[", "<h> bracket")
omap("l", "i{", "<l> brace")

-- Diagnostic keymaps
lmap("dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
lmap("dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
lmap("dh", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
lmap("dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
lmap("ds", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- document existing key chains
require("which-key").register({
  ["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
  ["<leader>l"] = { name = "[L]sp", _ = "which_key_ignore" },
})

-- toggle options
tmap("h", "<cmd>set invhlsearch<cr>", "[h]ighlight")
tmap("t", "<cmd>TransparentToggle<cr>", "[t]ransparent")
tmap("i", "<cmd>set invignorecase<cr>", "[i]gnorecase")
tmap("s", helpers.toggle_scrolloff, "[s]crolloff")
tmap("z", "<cmd>ZenMode<cr>", "[z]enMode")
tmap("o", "<cmd>ZenMode<cr>", "[z]enMode")
tmap("g", "<cmd>LazyGit<CR>", "LazyGit")
tmap("n", "<CMD>Noice disable<CR>", "disable noice")
tmap("p", "<CMD>TSPlaygroundToggle<CR>", "TreeSitter Playground")

nmap("<leader>cc", "<cmd>cd %:p:h<cr>", "Change work dir")

-- previous/next
if vim.g.neovide then
  nmap("<A-e>", "<cmd>tabNext<cr>", "next tab")
  nmap("<A-w>", "<cmd>tabclose<cr>", "close tab")
  nmap("<A-q>", "<cmd>tabprevious<cr>", "prev tab")
  nmap("<A-t>", "<cmd>tabnew<cr>", "new tab")
else
  nmap("]t", "<cmd>tabNext<cr>", "next tab")
  nmap("[t", "<cmd>tabprevious<cr>", "prev tab")
end

-- for debugging lua codes
nmap("<leader>w", function()
  if DEBUG then
    if vim.bo.filetype == "lua" then
      return "<cmd>wall<cr><cmd>source %<cr>"
    else
      return "<cmd>wall<cr>"
    end
  else
    return "<cmd>wall<cr>"
  end
end, { expr = true })
