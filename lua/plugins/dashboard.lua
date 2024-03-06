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

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = header,
        center = {
          {
            icon = "",
            desc = "New File",
            key = "n",
            key_format = " %s", -- remove default surrounding `[]`
            action = "enew",
          },
          {
            icon = "",
            desc = "Edit Config",
            key = "c",
            key_format = " %s", -- remove default surrounding `[]`
            action = "cd $HOME/.config/nvim|e init.lua",
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
