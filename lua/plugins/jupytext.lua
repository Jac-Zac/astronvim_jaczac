---@type LazySpec
return {
  "GCBallesteros/jupytext.nvim",
  config = true,
  -- event = "VeryLazy",
  opts = {
    custom_language_formatting = {
      python = {
        extension = "qmd",
        style = "quarto",
        force_ft = "quarto",
      },
      r = {
        extension = "qmd",
        style = "quarto",
        force_ft = "quarto",
      },
    },
  },
}
