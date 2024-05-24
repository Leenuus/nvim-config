-- themes
local themes = {
  "tokyonight-moon",
  "tokyonight-storm",
  "tokyonight-night",
  "tokyonight",
  "ayu-mirage",
  -- "ayu-dark",
}
local theme = themes[math.random(#themes)]
theme = "ayu-mirage"
local ok, _ = pcall(vim.cmd["colorscheme"], theme)
if not ok then
  vim.cmd("colorscheme default")
end
