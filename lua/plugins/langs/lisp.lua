return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python", "lisp" },
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
      vim.g["conjure#client_on_load"] = false

      vim.g["conjure#mapping#prefix"] = "<leader>"
      vim.g["conjure#debug"] = false

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
      vim.g["conjure#mapping#eval_visual"] = "e"
      vim.g["conjure#mapping#eval_comment_current_form"] = "ec"
      vim.g["conjure#mapping#eval_marked_form"] = "em"
      vim.g["conjure#mapping#eval_previous"] = "ep"
      vim.g["conjure#mapping#eval_replace_form"] = "e1"
    end,
    enabled = true,
  },
  {
    enabled = false,
    "bhurlow/vim-parinfer",
    ft = { "clojure", "fennel", "lisp" },
  },
  {
    enabled = false,
    "vlime/vlime",
    ft = { "clojure", "fennel", "lisp" },
  },
  {
    enabled = false,
    "kovisoft/slimv",
  },
  {
    "kovisoft/paredit",
    enabled = false,
  },
  {
    "guns/vim-sexp",
    init = function()
      vim.g.sexp_filetypes = ""
      vim.keymap.set({ "o", "x" }, "as", "<Plug>(sexp_outer_string)")
      vim.keymap.set({ "o", "x" }, "is", "<Plug>(sexp_inner_string)")
      vim.keymap.set({ "o", "x" }, "ae", "<Plug>(sexp_outer_element)")
      vim.keymap.set({ "o", "x" }, "ie", "<Plug>(sexp_inner_element)")
    end,
    ft = { "lisp" },
  },
}
