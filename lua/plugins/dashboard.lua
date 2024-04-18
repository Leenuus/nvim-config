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
        header = header,
        center = {
          {
            icon = "",
            desc = "New File",
            key = "e",
            key_format = " %s",
            action = "enew",
          },
          {
            icon = "",
            desc = "Help",
            key = "h",
            key_format = " %s",
            action = "Telescope help_tags",
          },
          {
            icon = "",
            desc = "Change Colorscheme",
            key = "t",
            key_format = " %s",
            action = "Telescope colorscheme",
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
