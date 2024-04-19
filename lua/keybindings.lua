local helpers = require("helpers")
local imap = helpers.map_insert
local nmap = helpers.map_normal
local tmap = helpers.map_toggle
local vmap = helpers.map_visual
local omap = helpers.map_operator
local cmap = helpers.map_command

-- disable keymaps
nmap("<Space>", "<Nop>")
vmap("<Space>", "<Nop>")
nmap("gf", "<Nop>")

nmap("Q", "<nop>")

-- jump around windows
nmap("<C-h>", "<cmd>wincmd h<cr>")
nmap("<C-j>", "<cmd>wincmd j<cr>")
nmap("<C-k>", "<cmd>wincmd k<cr>")
nmap("<C-l>", "<cmd>wincmd l<cr>")

-- resize window
nmap("<leader>w=", "<cmd>resize +3<cr>")
nmap("<leader>w+", "<cmd>resize -3<cr>")
nmap("<leader>w-", "<cmd>vertical resize +3<cr>")
nmap("<leader>w_", "<cmd>vertical resize -3<cr>")

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
vim.keymap.set({ "i", "s" }, "<C-]>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- navigation
nmap("<esc>", "<cmd>noh<cr><esc>zz")
imap("<esc>", "<esc>zz<cmd>noh<cr>")
nmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
nmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vmap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vmap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

nmap("H", "_")
vmap("H", "_")
omap("H", "_")

nmap("L", "$")
vmap("L", "$h")
omap("L", "$")

nmap("J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
vmap("J", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gjzz"<cr>')
nmap("K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')
vmap("K", '<cmd>execute "normal!" .. winheight(0) / 3 .. "gkzz"<cr>')

vmap("<", "<gv")
vmap(">", ">gv")

-- quit
nmap("<leader>q", "<cmd>x<cr>")
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
tmap("n", "<CMD>Noice disable<CR>", "disable noice")
tmap("p", "<CMD>TSPlaygroundToggle<CR>", "TreeSitter Playground")

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
  harpoon:list():add()
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

nmap("<leader>cc", "<cmd>cd %:p:h<cr>", "Change work dir")

-- previous/next
nmap("]t", "<cmd>tabNext<cr>", "next tab")
nmap("[t", "<cmd>tabprevious<cr>", "prev tab")

-- for debugging lua codes
nmap("<leader>w", function()
  if DEBUG then
    -- TODO: only source lua code
    if vim.bo.filetype == "lua" then
      return "<cmd>wall<cr><cmd>source %<cr>"
    else
      return "<cmd>wall<cr>"
    end
  else
    return "<cmd>wall<cr>"
  end
end, { expr = true })
