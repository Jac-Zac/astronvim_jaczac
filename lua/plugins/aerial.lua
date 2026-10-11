---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- Prefer local headings for Markdown; preserve the inherited order elsewhere.
    opts.backends = {
      _ = opts.backends,
      markdown = { "treesitter", "markdown", "lsp" },
    }
    return opts
  end,
}
