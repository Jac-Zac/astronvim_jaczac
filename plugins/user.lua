return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- nord theme
  { "shaunsingh/nord.nvim" },
  -- Better color theme
  { "m-demare/hlargs.nvim", opts = { color = "#d08770" }, event = "User AstroFile" },

  -- TODO make it work
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "User AstroFile",
  },
  -- https://github.com/Zeioth/markmap.nvim

  --  Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    event = "BufEnter *.md",
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
