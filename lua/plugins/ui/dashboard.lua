local headers = {
  {
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
  },
  {
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
  },
  {
    [[                                                       ]],
    [[                                                       ]],
    [[                                                       ]],
    [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
    [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
    [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
    [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
    [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
    [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
    [[                                                       ]],
    [[                                                       ]],
  },
  {
    [[                                          ]],
    [[                                          ]],
    [[                                          ]],
    [[    __                                    ]],
    [[   / /   ___  ___  ____  __  ____  _______]],
    [[  / /   / _ \/ _ \/ __ \/ / / / / / / ___/]],
    [[ / /___/  __/  __/ / / / /_/ / /_/ (__  ) ]],
    [[/_____/\___/\___/_/ /_/\__,_/\__,_/____/  ]],
    [[                                          ]],
    [[                                          ]],
    [[                                          ]],
  },
}

local notes_root = vim.env["NOTES_ROOT"]
local notes = {}
if notes_root ~= nil or notes_root == "" then
  notes = {
    icon = "󰎚  ",
    desc = "Notes",
    key = "n",
    key_format = " %s",
    action = "cd" .. notes_root .. "| FindFiles",
  }
end

local search_files = {}
local config = {}
if vim.cmd["FindFiles"] ~= nil then
  search_files = {
    icon = "  ",
    desc = "Search Files",
    key = "f",
    key_format = " %s",
    action = "FindFiles",
  }
  config = {
    icon = "  ",
    desc = "Config",
    key = "c",
    key_format = " %s",
    action = "cd" .. vim.fn.stdpath("config") .. "| FindFiles",
  }
end

local help = {}
local color = {}
local old_files = {}
if vim.cmd["Telescope"] ~= nil then
  help = {
    icon = "󰋖  ",
    desc = "Help",
    key = "h",
    key_format = " %s",
    action = "Telescope help_tags",
  }
  color = {
    icon = "  ",
    desc = "Change Colorscheme",
    key = "t",
    key_format = " %s",
    action = "Telescope colorscheme",
  }
  old_files = {
    icon = "󱋡  ",
    desc = "Recent Files",
    key = "o",
    key_format = " %s",
    action = "Telescope oldfiles",
  }
end

local diary = {}
if vim.env["DIARY_TODAY"] then
  local dir = vim.fs.dirname(vim.env["DIARY_TODAY"])
  diary = {
    icon = "󱋡  ",
    desc = "Diary Today",
    key = "d",
    key_format = " %s",
    action = "cd " .. dir .. "| e $DIARY_TODAY",
  }
end

return {
  dir = "~/Projects/Neovims/dashboard-nvim",
  event = "VimEnter",
  cond = function()
    return  vim.env["PAGER"] ~= "nvim"
  end,
  -- enabled = false,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = headers[math.random(#headers)],
        center = {
          {
            icon = "  ",
            desc = "New File",
            key = "e",
            key_format = " %s",
            action = "enew",
          },
          search_files,
          old_files,
          config,
          notes,
          help,
          color,
          diary,
          {
            icon = "  ",
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

    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "dashboard",
      callback = function()
        vim.b.minitrailspace_disable = true
      end,
    })
  end,
}
