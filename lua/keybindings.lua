local helpers = require("helpers")
local imap = helpers.map_insert
local nmap = helpers.map_normal
local tmap = helpers.map_toggle
local vmap = helpers.map_visual
local omap = helpers.map_operator
local cmap = helpers.map_command

-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- jump around windows
nmap("<C-h>", "<cmd>wincmd h<cr>", { silent = true })
nmap("<C-j>", "<cmd>wincmd j<cr>", { silent = true })
nmap("<C-k>", "<cmd>wincmd k<cr>", { silent = true })
nmap("<C-l>", "<cmd>wincmd l<cr>", { silent = true })

-- cmdline mode
cmap("<C-h>", "<C-w>")
cmap("<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
cmap("<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- insertion
imap("<c-h>", "<c-w>", { silent = true })
imap("<c-u>", "<esc>viwUea", { silent = true })
imap("<esc>", "<esc>zz", { silent = true })
imap("<c-_>", function()
  local api = require("Comment.api")
  api.toggle.linewise.current()
end, { silent = true })

-- navigation
nmap("<esc>", "<esc>zz")
nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

nmap("H", "_")
vmap("H", "_")
omap("H", "_")

nmap("L", "$")
vmap("L", "$h")
omap("L", "$")

-- TODO: better `J` which scroll down 1/4 screen
nmap("J", "10gjzz")
vmap("J", "10gj")
omap("J", "10gj")

nmap("K", "10gkzz")
vmap("K", "10gk")
omap("K", "10gk")

vmap("<", "<gv")
vmap(">", ">gv")

-- quit
nmap("<leader>w", "<cmd>wall<cr>")
nmap("<leader>q", "<cmd>x<cr>")
nmap("<leader>Q", "<cmd>q!<cr>")

-- redo
nmap("U", "<cmd>redo<cr>")

-- operators
omap("p", "i(")
omap("P", "a(")
omap("q", 'i"')
omap("Q", "i'")
omap("o", "i[")
omap("O", "i{")
-- omap("w", "iw")
-- omap("W", "iW")
omap("9", "(")
omap("0", ")")

-- Diagnostic keymaps
nmap("<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
nmap("<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
nmap("<leader>dh", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
nmap("<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
nmap("<leader>ds", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- document existing key chains
require("which-key").register({
  ["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
})

-- toggle options
tmap("h", "<cmd>set invhlsearch<cr>", "[H]ighlight")
tmap("t", "<cmd>TransparentToggle<cr>", "[T]ransparent")
tmap("i", "<cmd>set invignorecase<cr>", "[I]gnorecase")
tmap("s", helpers.setup_scrolloff, "[H]ighlight")
tmap("e", "<cmd>NvimTreeToggle<cr>", "[E]xplorer")
