return {
  -- renpy
  "chaimleib/vim-renpy",
  "folke/neodev.nvim",
  {
    "rafcamlet/nvim-luapad",
  },
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" }, -- etc
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
          local cmp = require("cmp")
          local config = cmp.get_config()
          table.insert(config.sources, {
            name = "buffer",
            option = {
              sources = {
                { name = "conjure" },
              },
            },
          })
          cmp.setup(config)
        end,
      },
    },
    config = function(_, opts)
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
    end,
    init = function()
      -- Set configuration options here
      vim.g["conjure#extract#tree_sitter#enabled"] = true
      vim.g["conjure#client#python#stdio#command"] = "env python -iq"

      -- NOTE: use ipython
      -- ipython --no-banner --no-confirm-exit -i
      -- vim.g["conjure#debug"] = true
      -- vim.g["conjure#client#python#stdio#command"] = "ipython --no-banner --no-confirm-exit -i"
      -- vim.g["conjure#client#python#stdio#prompt_pattern"] = "In %[%d+%]: "

      vim.g["conjure#mapping#prefix"] = "<leader>"

      --- mappings
      vim.g["conjure#mapping#enable_defaults"] = false
      vim.g["conjure#mapping#doc_word"] = "eh"
      vim.g["conjure#mapping#log_vsplit"] = "el"
      vim.g["conjure#log#hud#anchor"] = "SE"

      -- evaluate
      vim.g["conjure#mapping#eval_current_form"] = "ee"
      vim.g["conjure#mapping#eval_root_form"] = "er"
      vim.g["conjure#mapping#eval_buf"] = "ef"
      vim.g["conjure#mapping#eval_word"] = "ew"
      vim.g["conjure#mapping#eval_visual"] = "E"
      vim.g["conjure#mapping#eval_comment_current_form"] = "ec"
      vim.g["conjure#mapping#eval_marked_form"] = "em"
      vim.g["conjure#mapping#eval_previous"] = "ep"
      vim.g["conjure#mapping#eval_replace_form"] = "e1"
    end,
  },
}
