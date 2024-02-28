local helpers = require("helpers")
local map_insert = helpers.map_insert
local map_normal = helpers.map_normal
local map_toggle = helpers.map_toggle
local map_visual = helpers.map_visual
local map_operator = helpers.map_operator
local map_command = helpers.map_command

-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- cmdline mode
map_command("<C-h>", "<C-w>")
map_command("<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
map_command("<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- insertion
map_insert("<c-h>", "<c-w>", { silent = true })
map_insert("<c-u>", "<esc>viwUea", { silent = true })
map_insert("<esc>", "<esc>zz", { silent = true })

-- navigation
map_normal("<esc>", "<esc>zz")
map_normal("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map_normal("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map_normal("H", "_")
map_visual("H", "_")
map_operator("H", "_")

map_normal("L", "$")
map_visual("L", "$h")
map_operator("L", "$")

map_normal("J", "10gjzz")
map_visual("J", "10gj")
map_operator("J", "10gj")

map_normal("K", "10gkzz")
map_visual("K", "10gk")
map_operator("K", "10gk")

map_visual("<", "<gv")
map_visual(">", ">gv")

-- quit
map_normal("<leader>w", "<cmd>w<cr>")
map_normal("<leader>q", "<cmd>x<cr>")
map_normal("<leader>Q", "<cmd>q!<cr>")
-- map_normal('Q', "mmggvG=`m")

-- redo
map_normal("U", "<cmd>redo<cr>")

-- operators
map_operator("p", "i(")
map_operator("P", "a(")
map_operator("q", 'i"')
map_operator("Q", "i'")
map_operator("o", "i[")
map_operator("O", "i{")
map_operator("w", "iw")
map_operator("W", "iW")

-- Diagnostic keymaps
map_normal("<leader>dp", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map_normal("<leader>dn", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map_normal("<leader>dh", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map_normal("<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- document existing key chains
require("which-key").register({
  ["<leader>d"] = { name = "[D]iagnostics", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
})

-- toggle options
map_toggle("h", "<cmd>set invhlsearch<cr>", "[H]ighlight")
map_toggle("t", "<cmd>TransparentToggle<cr>", "[T]ransparent")
map_toggle("i", "<cmd>set invignorecase<cr>", "[I]gnorecase")
map_toggle("s", helpers.setup_scrolloff, "[H]ighlight")
map_toggle("e", "<cmd>NvimTreeToggle<cr>", "[E]xplorer")
