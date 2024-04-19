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
            icon = " ",
            desc = "New File",
            key = "e",
            key_format = " %s",
            action = "enew",
          },
          {
            icon = " ",
            desc = "Search Files",
            key = "s",
            key_format = " %s",
            action = "FindFiles",
          },
          {
            icon = "󰎚 ",
            desc = "Notes",
            key = "n",
            key_format = " %s",
            action = "cd" .. notes_root .. "| FindFiles",
          },
          {
            icon = " ",
            desc = "Config",
            key = "c",
            key_format = " %s",
            action = "cd" .. vim.fn.stdpath("config") .. "| FindFiles",
          },
          {
            icon = "󰋖 ",
            desc = "Help",
            key = "h",
            key_format = " %s",
            action = "Telescope help_tags",
          },
          {
            icon = " ",
            desc = "Change Colorscheme",
            key = "t",
            key_format = " %s",
            action = "Telescope colorscheme",
          },
          {
            icon = " ",
            desc = "Music Player",
            key = "m",
            key_format = " %s",
            action = "Telescope mpc",
          },
          -- TODO: implement my news reader neovim frontend
          -- {
          --   icon = "",
          --   desc = "News Reader",
          --   key = "r",
          --   key_format = " %s",
          --   action = ":Reader",
          -- },
          -- TODO: Project Manager
          -- {
          --   icon = "",
          --   desc = "Projects",
          --   key = "r",
          --   key_format = " %s",
          --   action = ":Projects",
          -- },
          {
            icon = " ",
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
