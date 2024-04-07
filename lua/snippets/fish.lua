local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local discard_output = s(
  "do",
  fmt([[>/dev/null 2>&1{}]], {
    insert(1),
  })
)

local if_installed = s(
  "ty",
  fmt(
    [[if type {} >/dev/null 2>&1
  {}
end
]],
    {
      insert(1, "program"),
      insert(2, "command"),
    }
  )
)

local fish_snips = { discard_output, if_installed }

return fish_snips
