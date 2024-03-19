local helpers = require("helpers")
local nmap = helpers.map_normal
local imap = helpers.map_insert

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  module = true,
  dependencies = { "nvim-lua/plenary.nvim" },
}
