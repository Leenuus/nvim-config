local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- TODO: echo message should have the same
-- program specified by program, the first
-- argument user input
local if_installed = s(
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

local parse_opts = s(
  "parse",
  fmt(
    [[print_help() {{
	exit 1
}}
opts=$(getopt -o {} --long {} -- "$@") || print_help
eval set -- "$opts"

while (($#)); do
	case $1 in
  {}) {};;
  --) shift; break ;;
	*) false ;;
	esac
	shift
done
    ]],
    {
      insert(1, "short"),
      insert(2, "long"),
      insert(3, "match"),
      insert(4, "action"),
    }
  )
)

local ifz = s(
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

local ifn = s(
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

local yes_or_no = s(
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

local if_tmux = s(
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
local main = s(
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

local tmux_rename = s(
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

local trap = s(
  "trap",
  fmt(
    [[trap '{}' INT EXIT

{}]],
    {
      insert(1, "cleanup"),
      insert(2),
    }
  )
)

local discard_output = s(
  "dd",
  fmt([[>/dev/null 2>&1{}]], {
    insert(1),
  })
)

local copy = s("copy", fmt([[xclip -selection clipboard]], {}))

local readline = s(
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

local replace = s(
  "replace",
  fmt([["${{{}//{}/{}}}"]], {
    insert(1, "var"),
    insert(2, "search"),
    insert(3, "replace"),
  })
)

local get_suffix = s(
  "suf",
  fmt([["${{{}##*{}}}"]], {
    insert(1, "var"),
    insert(2, "delimeter"),
  })
)

local bash_snips = {
  if_installed,
  parse_opts,
  ifz,
  ifn,
  yes_or_no,
  if_tmux,
  main,
  tmux_rename,
  trap,
  discard_output,
  copy,
  readline,
  replace,
  get_suffix,
}

return bash_snips
