---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable-next-line: missing-fields
      config = {
        harper_ls = {
          cmd = { "harper-ls", "--stdio" },
          -- Only attach to Typst, Markdown, TeX, and plain text files
          filetypes = { "markdown", "text", "tex", "typst" },
          settings = {
            ["harper-ls"] = {
              codeActions = { ForceStable = true },
              linters = {
                SpellCheck = false,
                SentenceCapitalization = false,
                SpelledNumbers = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "harper_ls" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "harper-ls" })
    end,
  },
}
