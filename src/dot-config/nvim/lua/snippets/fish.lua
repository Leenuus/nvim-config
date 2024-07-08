local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local c = ls.choice_node
local t = ls.text_node

local discard_output = s(
  "dd",
  c(1, {
    t(">/dev/null 2>&1"),
    t(">/dev/null"),
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
      i(1, "program"),
      i(2, "command"),
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
      i(0, "rename-window"),
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
      i(1, "program"),
      i(2, "alias"),
      rep(1),
    }
  )
)

local color = s(
  "co",
  fmt(
    [[set_color {}
{}
set_color normal
]],
    {
      c(1, {
        t("red"),
        t("normal"),
        t("blue"),
        t("green"),
      }),
      i(0),
    }
  )
)

local self = s(
  "self",
  fmt(
    [[set -l SCRIPT (status filename)
set -l DIR (status dirname)]],
    {},
    { delimiters = "<>" }
  )
)

local fzf = s(
  "fzf",
  fmt(
    [[SHELL=bash fzf --bind='ctrl-h:backward-kill-word,ctrl-j:preview-page-down,ctrl-k:preview-page-up' <>
]],
    {
      c(1, {
        fmt("-d{} -n{}", { i(1, ":"), i(2, "1") }),
        t(""),
      }),
    },
    { delimiters = "<>" }
  )
)

local fish_snips = {
  discard_output,
  if_installed,
  if_tmux,
  abbr,
  color,
  self,
  fzf
}

return fish_snips
