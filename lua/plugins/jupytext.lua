return {
  "GCBallesteros/jupytext.nvim",
  config = true,
  -- lazy = true,
  event = "VeryLazy",
  ops = {
    style = "markdown",
    output_extension = "md",
    force_ft = "markdown",
  },
  -- Depending on your nvim distro or config you may need to make the loading not lazy
}
