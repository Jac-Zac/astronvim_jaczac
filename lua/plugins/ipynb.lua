-- NOTE: To improve but I like it ! I still need to test the images.
return {
  "ajbucci/ipynb.nvim",
  dir = "/Users/jaczac/projects/ipynb.nvim",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    "folke/snacks.nvim", -- optional, for inline images
    "nvim-tree/nvim-web-devicons", -- optional, for language icons
  },
  opts = {
    keymaps = {
      -- Match my iron muscle memory: Ctrl+Enter runs and advances.
      execute_and_next = "<C-CR>", -- run + jump to next cell
      execute_cell = "<S-CR>", -- run + stay in place
      -- execute_and_insert stays <M-CR> (run + insert below)
    },
  },
}
