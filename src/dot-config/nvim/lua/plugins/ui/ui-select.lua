return {
  {
    event = "VeryLazy",
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
}
