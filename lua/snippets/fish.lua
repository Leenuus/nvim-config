local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snip1 = s(
  "iftr",
  fmt(
    [[if [ -n "$TMUX" ]
  tmux rename-window {}
end

{}

if [ -n "$TMUX" ]
  tmux set-option -w automatic-rename on
end

{}]],
    {
      insert(1, "win_name"),
      insert(2, "command"),
      insert(3),
    }
  )
)

local snip2 = s(
  "do",
  fmt([[>/dev/null 2>&1{}]], {
    insert(1),
  })
)

local snip3 = s(
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

local fish_snips = { snip1, snip2, snip3 }

return fish_snips
