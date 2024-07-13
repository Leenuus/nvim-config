local ls = require("luasnip")
local s = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local func = ls.function_node
local c = ls.choice_node
local t = ls.text_node
local rep = require("luasnip.extras").rep

local if_installed = s(
  "ty",
  fmt(
    [[if ! type {} >/dev/null 2>&1; then
  echo '{} not installed'
  exit 1
fi
{}]],
    {
      insert(1, "prog"),
      rep(1),
      -- func(function(args, parent, user_args)
      --   local _ = parent
      --   local _ = user_args
      --   return args[1][1]
      -- end, { 1 }),
      insert(0),
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

local simple_parse_opt = s(
  "pa",
  fmt(
    [[while [ "$#" -gt 0 ]; do
  case "$1" in
  {}) {} ;;
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

local ifz = s(
  "ifz",
  fmt(
    [[if [ -z "${}" ]; then
  {}
fi
]],
    {
      insert(1, "var"),
      insert(2, "command"),
    }
  )
)

local ifn = s(
  "ifn",
  fmt(
    [[if [ -n "${}" ]; then
  {}
fi
]],
    {
      insert(1, "var"),
      insert(2, "command"),
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
]],
    {
      insert(0, "rename-window"),
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
      insert(0, "command"),
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
]],
    {
      insert(1, "win_name"),
      insert(2, "command"),
    }
  )
)

local trap = s(
  "trap",
  fmt([[trap '{}' INT]], {
    insert(0, "echo cleanup"),
  })
)

local discard_output = s(
  "dd",
  c(1, {
    t(">/dev/null 2>&1"),
    t(">/dev/null"),
  })
)

local copy = s("copy", fmt([[xclip -selection clipboard]], {}))

local readline = s(
  "rl",
  fmt(
    [[while IFS= read -r line; do
  echo "$line"
done]],
    {}
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
  fmt([["${{{}#{}}}"]], {
    insert(1, "var"),
    insert(2, "prefix"),
  })
)

local get_prefix = s(
  "pre",
  fmt([[${{{}%{}}}]], {
    insert(1, "var"),
    insert(2, "suffix"),
  })
)

local slice = s(
  "slice",
  fmt([[${{{}:{}:{}}}]], {
    insert(1, "var"),
    insert(2, "from"),
    insert(3, "length"),
  })
)

local last_pid = s("last_pid", fmt([[$!]], {}))

-- NOTE: for entire ANSI color codes
-- https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
-- or notes: bash-ansi-color.md
local color = s(
  "color",
  fmt(
    [[BLACK=‘\033[30m’
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
PURPLE='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'
NC='\033[0m'
  ]],
    {}
  )
)

local script_self = s("self", t({ 'SCRIPT=$(realpath "$0")', 'DIR=$(dirname "$SCRIPT")' }))

-- FIXME: problematic somehow
local source = s("source?", t("(return 0 2>/dev/null) && sourced=1 || not_sourced=1"))

local fzf = s(
  "fzf",
  fmt(
    [[SHELL=bash fzf --bind='ctrl-h:backward-kill-word,ctrl-j:preview-page-down,ctrl-k:preview-page-up' <>
]],
    {
      c(1, {
        fmt("-d{} -n{}", { insert(1, ":"), insert(2, "1") }),
        t(""),
      }),
    },
    { delimiters = "<>" }
  )
)

local shell_bang = s("bang", {
  t("#!/bin/bash"),
})

local off = s("off", {
  t("shellcheck disable=SC"),
})

local if_file_not_exist = s(
  "iffn",
  fmt(
    [[if [ ! -f "<>" ];then
  <>
fi
  ]],
    {
      insert(1, "file"),
      insert(0),
    },
    { delimiters = "<>" }
  )
)

local tenary = s(
  "?",
  c(1, {
    fmt([[<> && <>]], { insert(1, "cond"), insert(2, "true") }, { delimiters = "<>" }),
    fmt([[<> || <>]], { insert(1, "cond"), insert(2, "false") }, { delimiters = "<>" }),
  })
)

local rofi = s("rofi", t("rofi -dmenu -i --matching fuzzy"))

local read = s(
  "rr",
  fmt([[IFS='<>' read -r <>]], {
    insert(1, ":"),
    insert(0),
  }, { delimiters = "<>" })
)

local match = s(
  "ma",
  fmt(
    [[match(<>, /<>/);
print substr(<>, RSTART, RLENGTH)
]],
    {
      insert(1, "var"),
      insert(2, "regex"),
      rep(1),
    },
    { delimiters = "<>" }
  )
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
  get_prefix,
  slice,
  simple_parse_opt,
  last_pid,
  color,
  -- source,
  script_self,
  fzf,
  shell_bang,
  off,
  if_file_not_exist,
  tenary,
  rofi,
  read,
  match,
}

return bash_snips
