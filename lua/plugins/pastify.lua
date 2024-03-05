return {
  "TobinPalmer/pastify.nvim",
  cmd = { "Pastify" },
  config = function()
    -- require('pastify').setup {
    --   opts = {
    --     apikey = "YOUR API KEY (https://api.imgbb.com/)", -- Needed if you want to save online.
    --   },
    -- }
    -- p
    -- FIXME: it breaks when you are in non-global python venv
    -- possible solutions: 1. lazy loading when needed
    require("pastify").setup({
      opts = {
        absolute_path = false, -- use absolute or relative path to the working directory
        -- apikey = "", -- Api key, required for online saving
        local_path = "images/", -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
        save = "local", -- Either 'local' or 'online'
      },
      ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
        html = '<img src="$IMG$" alt="">',
        markdown = "![]($IMG$)",
        tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
      },
    })
  end,
}
