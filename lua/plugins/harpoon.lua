local helpers = require("helpers")
local map = helpers.map
local nmap = helpers.map_normal
local lmap = helpers.map_leader

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  module = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
    lmap("<CR>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon list" })
    nmap("<CR>", function()
      harpoon:list():add()
    end, { desc = "Append buffer to harpoon" })
    map({ "n", "i" }, "<f1>", function()
      harpoon:list():select(1)
    end, { desc = "Switch to 1st harpoon buffer" })
    map({ "n", "i" }, "<f2>", function()
      harpoon:list():select(2)
    end, { desc = "Switch to 2nd harpoon buffer" })
    map({ "n", "i" }, "<f3>", function()
      harpoon:list():select(3)
    end, { desc = "Switch to 3rd harpoon buffer" })
    map({ "n", "i" }, "<f4>", function()
      harpoon:list():select(4)
    end, { desc = "Switch to 4th harpoon buffer" })
  end,
}
