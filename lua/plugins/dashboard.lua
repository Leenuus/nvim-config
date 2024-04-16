local header = {
  [[                                    ]],
  [[                                    ]],
  [[                                    ]],
  [[          ▀████▀▄▄              ▄█  ]],
  [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█  ]],
  [[    ▄        █          ▀▀▀▀▄  ▄▀   ]],
  [[   ▄▀ ▀▄      ▀▄              ▀▄▀   ]],
  [[  ▄▀    █     █▀   ▄█▀▄      ▄█     ]],
  [[  ▀▄     ▀▄  █     ▀██▀     ██▄█    ]],
  [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █   ]],
  [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀   ]],
  [[   █   █  █      ▄▄           ▄▀    ]],
  [[                                    ]],
  [[                                    ]],
}

local header1 = {
  [[                                            ]],
  [[                                            ]],
  [[                                            ]],
  [[             _                              ]],
  [[            | |                             ]],
  [[ _ __   ___ | | _____ _ __ ___   ___  _ __  ]],
  [[| '_ \ / _ \| |/ / _ \ '_ ` _ \ / _ \| '_ \ ]],
  [[| |_) | (_) |   <  __/ | | | | | (_) | | | |]],
  [[| .__/ \___/|_|\_\___|_| |_| |_|\___/|_| |_|]],
  [[| |                                         ]],
  [[|_|                                         ]],
  [[                                            ]],
  [[                                            ]],
}

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  -- enabled = false,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    local notes_root = vim.fn.expand("$HOME/Projects/notes")

    require("dashboard").setup({
      theme = "doom",
      config = {
        header = header1,
        center = {
          {
            icon = "",
            desc = "New File",
            key = "n",
            key_format = " %s",
            action = "enew",
          },
          {
            icon = "",
            desc = "Edit Config",
            key = "c",
            key_format = " %s",
            action = "cd" .. vim.fn.stdpath("config") .. "|" .. "Telescope find_files",
          },
          {
            icon = "",
            desc = "Edit Notes",
            key = "n",
            key_format = " %s",
            action = "cd" .. notes_root .. "|" .. "Telescope find_files",
          },
          {
            icon = "",
            desc = "Change Colorscheme",
            key = "t",
            key_format = " %s",
            action = "Telescope colorscheme",
          },
          {
            icon = "",
            desc = "Quit Neovim",
            key = "q",
            key_format = " %s",
            action = "quit",
          },
        },
        footer = {
          "Treasure Your Time!!!",
        },
      },
    })
  end,
}
