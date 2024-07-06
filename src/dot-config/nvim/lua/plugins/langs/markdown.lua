return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "TobinPalmer/pastify.nvim",
    cmd = { "Pastify" },
    config = function()
      pcall(require("pastify").setup, {
        opts = {
          absolute_path = false,  -- use absolute or relative path to the working directory
          -- apikey = "", -- Api key, required for online saving
          local_path = "images/", -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
          save = "local",         -- Either 'local' or 'online'
        },
        ft = {                    -- Custom snippets for different filetypes, will replace $IMG$ with the image url
          html = '<img src="$IMG$" alt="">',
          markdown = "![]($IMG$)",
          tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
        },
      })
    end,
  },
}
