local helpers = require("helpers")
local imap = helpers.map_insert
local nmap = helpers.map_normal
local tmap = helpers.map_toggle
local vmap = helpers.map_visual
local omap = helpers.map_operator
local cmap = helpers.map_command

-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

nmap("Q", "<nop>")

-- jump around windows
nmap("<C-h>", "<cmd>wincmd h<cr>", { silent = true })
nmap("<C-j>", "<cmd>wincmd j<cr>", { silent = true })
nmap("<C-k>", "<cmd>wincmd k<cr>", { silent = true })
nmap("<C-l>", "<cmd>wincmd l<cr>", { silent = true })

-- resize window
nmap("<leader>wj", "<cmd>resize +3<cr>", { silent = true })
nmap("<leader>wk", "<cmd>resize -3<cr>", { silent = true })
nmap("<leader>wl", "<cmd>vertical resize +3<cr>", { silent = true })
nmap("<leader>wh", "<cmd>vertical resize -3<cr>", { silent = true })

-- split window
nmap("<c-\\>", "<C-W>v")
imap("<c-\\>", "<esc><C-W>va")
nmap("<c-s>", "<C-W>s")
imap("<c-s>", "<esc><C-W>sa")

-- cmdline mode
cmap("<C-h>", "<C-w>")
cmap("<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
cmap("<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- insertion
imap("<c-h>", "<c-w>", { silent = true })
imap("<c-u>", "<esc>viwUea", { silent = true })
imap("<esc>", "<esc>zz", { silent = true })
vim.keymap.set({ "i", "s" }, "<C-_>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- navigation
nmap("<esc>", "<cmd>noh<cr><esc>zz")
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

nmap("J", '<cmd>execute "normal!" .. winheight(0) / 4 .. "gjzz"<cr>')
vmap("J", '<cmd>execute "normal!" .. winheight(0) / 4 .. "gjzz"<cr>')
omap("J", '<cmd>execute "normal!" .. winheight(0) / 4 .. "gjzz"<cr>')

nmap("K", '<cmd>execute "normal!" .. winheight(0) / 4 .. "gkzz"<cr>')
vmap("K", '<cmd>execute "normal!" .. winheight(0) / 4 .. "gkzz"<cr>')
omap("K", '<cmd>execute "normal!" .. winheight(0) / 4 .. "gkzz"<cr>')

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
omap(",", "i<")
omap(".", "a<")

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

-- harpoon
local harpoon = require("harpoon")
harpoon:setup({})

require("which-key").register({
  ["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
})
nmap("<leader>hl", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon list" })
nmap("<leader>ha", function()
  harpoon:list():append()
end, { desc = "Append buffer to harpoon" })
nmap("<f1>", function()
  harpoon:list():select(1)
end, { desc = "Switch to 1st harpoon buffer" })
nmap("<f2>", function()
  harpoon:list():select(2)
end, { desc = "Switch to 2nd harpoon buffer" })
nmap("<f3>", function()
  harpoon:list():select(3)
end, { desc = "Switch to 3rd harpoon buffer" })
nmap("<f4>", function()
  harpoon:list():select(4)
end, { desc = "Switch to 4th harpoon buffer" })
imap("<f1>", function()
  harpoon:list():select(1)
end, { desc = "Switch to 1st harpoon buffer" })
imap("<f2>", function()
  harpoon:list():select(2)
end, { desc = "Switch to 2nd harpoon buffer" })
imap("<f3>", function()
  harpoon:list():select(3)
end, { desc = "Switch to 3rd harpoon buffer" })
imap("<f4>", function()
  harpoon:list():select(4)
end, { desc = "Switch to 4th harpoon buffer" })

-- file explorer
tmap("e", "<cmd>Oil<CR>", "[e]xplorer")
tmap("E", function()
  local dir = require("helpers").find_git_root()
  require("oil").open(dir)
end, "[e]plorer git root")

-- edit config
nmap("<leader>cc", function()
  local configpath = vim.fn.stdpath("config")
  require("telescope.builtin").find_files({
    cwd = configpath,
    hidden = false,
    no_ignore = true,
  })
end)

-- move between textobjects
