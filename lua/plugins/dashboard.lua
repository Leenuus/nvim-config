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

-- local function get_quote()
--    local handle = io.popen('random-quote -r', 'r')
--    if handle ~= nil then
--       local res = handle:read('*a')
--       handle:close()
--       return { res }
--    else
--       return {}
--    end
-- end

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
            icon = "📖  ",
            desc = "Edit Config",
            key = "c",
            key_format = " %s", -- remove default surrounding `[]`
            -- TODO: if in tmux, rename current window
            action = "cd $HOME/.config/nvim|e init.lua",
          },
          {
            icon = "✏️   ",
            desc = "Change Colorscheme",
            key = "t",
            key_format = " %s",
            action = "Telescope colorscheme",
          },
          {
            icon = "✈️   ",
            desc = "Quit Neovim",
            key = "q",
            key_format = " %s",
            action = "quit",
          },
        },
        -- footer = {
        --    "Fuck You Stupid Shit"
        -- }
      },
    })
  end,
}
