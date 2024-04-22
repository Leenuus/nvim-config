local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local discard_output = s(
  "dd",
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

local if_tmux = s(
  "ift",
  fmt(
    [[if test -n "$TMUX"
    {}
end]],
    {
      insert(0, "rename-window"),
    }
  )
)

local abbr = s(
  "abbr",
  fmt(
    [[if type {} >/dev/null 2>&1
  abbr -a {} {}
end
]],
    {
      insert(1, "program"),
      insert(2, "alias"),
      rep(1),
    }
  )
)

local fish_snips = { discard_output, if_installed, if_tmux, abbr }

return fish_snips
