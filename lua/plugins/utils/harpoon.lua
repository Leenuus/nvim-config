return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
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
      local cmd = string.format("HarpoonSelect%d", i)
      vim.api.nvim_create_user_command(cmd, function()
        harpoon:list():select(i)
      end, {})
      vim.keymap.set("n", string.format("<F%d>", i), string.format("<CMD>%s<CR>", cmd))
    end
    vim.keymap.set("n", "<leader>aa", "<CMD>HarpoonAdd<CR>")
    vim.keymap.set("n", "<leader>ai", "<CMD>HarpoonList<CR>")
  end,
}
