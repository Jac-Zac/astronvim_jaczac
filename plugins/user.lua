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
  -- {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  "shaunsingh/nord.nvim",
  --  https://github.com/Zeioth/markmap.nvim
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  config = function()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
  cmd = {
    "PeekOpen",
    "PeekClose",
  },
}

-- {
-- "Zeioth/markmap.nvim",
-- build = "yarn global add markmap-cli",
-- cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
-- opts = {
-- html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
-- hide_toolbar = false, -- (default)
-- grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
-- },
-- config = function(_, opts) require("markmap").setup(opts) end,
-- },
