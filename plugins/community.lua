return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.pack.python" },
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
