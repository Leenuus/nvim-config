local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- TODO: echo message should have the same
-- program specified by program, the first
-- argument user input
local bash_snip1 = s(
  "ty",
  fmt(
    [[if ! type {} >/dev/null 2>&1; then
  echo "not installed"
  exit 1
fi
]],
    {
      insert(1, "program"),
    }
  )
)

local bash_snip2 = s(
  "parse",
  fmt(
    [[while [ "$#" -gt 0 ];do
  case "$1" in
    {} ) {};;
    *) ;;
  esac
  shift
done]],
    {
      insert(1, "match"),
      insert(2, "command"),
    }
  )
)

local bash_snip3 = s(
  "ifz",
  fmt(
    [[if [ -z "${}" ]; then
  {}
fi

{}]],
    {
      insert(1, "var"),
      insert(2, "command"),
      insert(3),
    }
  )
)

local bash_snip4 = s(
  "ifn",
  fmt(
    [[if [ -n "${}" ]; then
  {}
fi

{}]],
    {
      insert(1, "var"),
      insert(2, "command"),
      insert(3),
    }
  )
)

local bash_snip5 = s(
  "ye",
  fmt(
    [[yes_or_no() {{
  local message=$1
  while true; do
    # shellcheck disable=SC2162
    read -p "$message [y/n]: " yn
    case "$yn" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    esac
  done
}}
]],
    {}
  )
)

local bash_snip7 = s(
  "ift",
  fmt(
    [[if [ -n "$TMUX" ]; then
  tmux {}
fi

{}]],
    {
      insert(1, "rename-window"),
      insert(2),
    }
  )
)

-- NOTE: to escape delimeters, double them
local bash_snip8 = s(
  "main",
  fmt(
    [[#!/bin/bash

main(){{
  {}
}}

main]],
    {
      insert(1, "command"),
    }
  )
)

local bash_snip9 = s(
  "iftr",
  fmt(
    [[if [ -n "$TMUX" ]; then
  tmux rename-window {}
fi

{}

if [ -n "$TMUX" ]; then
  tmux set-option -w automatic-rename on
fi

{}]],
    {
      insert(1, "win_name"),
      insert(2, "command"),
      insert(3),
    }
  )
)

local bash_snip10 = s(
  "tr",
  fmt(
    [[trap '{}' INT EXIT

{}]],
    {
      insert(1, "cleanup"),
      insert(2),
    }
  )
)

local bash_snip11 = s(
  "do",
  fmt([[>/dev/null 2>&1{}]], {
    insert(1),
  })
)

local bash_snip12 = s(
  "pr",
  fmt([[proxychains -f "$HOME/.proxychains.conf" {}]], {
    insert(1),
  })
)

local snip13 = s("copy", fmt([[xclip -selection clipboard]], {}))

local snip14 = s(
  "readline",
  fmt(
    [[while IFS= read -r line; do
  echo "$line"
done < {}
  ]],
    {
      insert(1, "input"),
    }
  )
)

local bash_snips = {
  bash_snip1,
  bash_snip2,
  bash_snip3,
  bash_snip4,
  bash_snip5,
  bash_snip7,
  bash_snip8,
  bash_snip9,
  bash_snip10,
  bash_snip11,
  bash_snip12,
  snip13,
  snip14,
}

return bash_snips
