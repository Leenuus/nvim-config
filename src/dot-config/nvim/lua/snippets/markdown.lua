local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local t = ls.text_node

local link = s(
  "link",
  fmt([[[<>](<>)<>]], {
    i(1, "text"),
    i(2, "link"),
    i(0),
  }, { delimiters = "<>" })
)

local img = s(
  "link",
  fmt([[![<>](<>)<>]], {
    i(1, "text"),
    i(2, "link"),
    i(0),
  }, { delimiters = "<>" })
)

local markdown_snips = { link, img }

return markdown_snips
