return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    -- basic telescope configuration
    local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers")
    --     .new({}, {
    --       prompt_title = "Harpoon",
    --       finder = require("telescope.finders").new_table({
    --         results = file_paths,
    --       }),
    --       previewer = conf.file_previewer({}),
    --       sorter = conf.generic_sorter({}),
    --     })
    --     :find()
    -- end
    -- vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():append()
    end, { desc = "Append buffer to harpoon" })
    vim.keymap.set("n", "<f1>", function()
      harpoon:list():select(1)
    end, { desc = "Switch to 1st harpoon buffer" })
    vim.keymap.set("n", "<f2>", function()
      harpoon:list():select(2)
    end, { desc = "Switch to 2nd harpoon buffer" })
    vim.keymap.set("n", "<f3>", function()
      harpoon:list():select(3)
    end, { desc = "Switch to 3rd harpoon buffer" })
    vim.keymap.set("n", "<f4>", function()
      harpoon:list():select(4)
    end, { desc = "Switch to 4th harpoon buffer" })
  end,
}
