local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local fish_snip1 = s(
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

local fish_snips = { fish_snip1, snip2 }

return fish_snips
