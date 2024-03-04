local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local bash_snip1 = s(
  "ty",
  fmt(
    [[if ! type {} >/dev/null 2>&1; then
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
    [[while true; do
  echo -n '{}'
  read -r -p " [y/n]: " yn
  case $yn in
      [Yy]*) yes=1; break;;  
      [Nn]*) yes=0; break;;
  esac
done

{}]],
    {
      insert(1, "prompt"),
      insert(2),
    }
  )
)

local bash_snip6 = s(
  "ify",
  fmt(
    [[if [ "$yes" -eq 1 ]; then
  {}
elif [ "$yes" -eq 0 ];then
  {}
else
  echo "Unspecified yes or no, do nothing to protect the script"
fi
yes=''

{}]],
    {
      insert(1, "command"),
      insert(2, "command"),
      insert(3),
    }
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

local bash_snips = { bash_snip1, bash_snip2, bash_snip3, bash_snip4, bash_snip5, bash_snip6, bash_snip7, bash_snip8 }

return bash_snips