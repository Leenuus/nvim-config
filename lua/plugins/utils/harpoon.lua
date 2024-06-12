return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  module = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
    vim.api.nvim_create_user_command("HarpoonList", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {})
    vim.api.nvim_create_user_command("HarpoonAdd", function()
      harpoon:list():add()
    end, {})
    for i = 1, 5 do
      vim.api.nvim_create_user_command(string.format("HarpoonSelect%d", i), function()
        harpoon:list():select(i)
      end, {})
    end

  end,
}
