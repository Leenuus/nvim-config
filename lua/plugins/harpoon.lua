local helpers = require("helpers")
local nmap = helpers.map_normal
local imap = helpers.map_insert

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
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
  end,
}
