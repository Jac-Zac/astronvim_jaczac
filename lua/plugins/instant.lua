return {
  {
    "jbyuki/instant.nvim",
    config = function() vim.g.instant_username = os.getenv "USER" end,
  },
}
