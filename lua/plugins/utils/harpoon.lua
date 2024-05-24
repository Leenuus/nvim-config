return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  module = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    vim.keymap.set("n", "<leader><CR>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon list" })

    vim.keymap.set("n", "<leader>aH", function()
      harpoon:list():add()
    end, { desc = "Append buffer to harpoon" })

    vim.keymap.set({ "n", "i" }, "<f1>", function()
      harpoon:list():select(1)
    end, { desc = "Switch to 1st harpoon buffer" })
    vim.keymap.set({ "n", "i" }, "<f2>", function()
      harpoon:list():select(2)
    end, { desc = "Switch to 2nd harpoon buffer" })
    vim.keymap.set({ "n", "i" }, "<f3>", function()
      harpoon:list():select(3)
    end, { desc = "Switch to 3rd harpoon buffer" })
    vim.keymap.set({ "n", "i" }, "<f4>", function()
      harpoon:list():select(4)
    end, { desc = "Switch to 4th harpoon buffer" })
  end,
}
