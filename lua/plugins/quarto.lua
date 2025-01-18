---@type LazySpec
return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local quarto = require "quarto"
      quarto.setup {
        lspFeatures = {
          enabled = true,
          languages = { "r", "python", "rust" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "molten",
        },
      }

      -- Automatically activate otter for specified file types
      vim.api.nvim_create_autocmd({ "BufRead", "BufEnter", "BufNewFile" }, {
        pattern = { "*.qmd", "*.md", "*.ipynb" }, -- Adjust patterns as necessary
        callback = function()
          local otter = require "otter"
          otter.activate() -- Activate otter for the current buffer
        end,
      })

      -- Key mappings for Quarto runner
      local runner = require "quarto.runner"
      vim.keymap.set("n", "<Leader>ma", runner.run_above, { desc = "Quarto run cell and above", silent = true })
      vim.keymap.set("n", "<Leader>mp", quarto.quartoPreview, { desc = "Quarto Preview", silent = true })

      -- Run cell and go to the next one
      vim.keymap.set("n", "<C-CR>", function()
        runner.run_cell() -- Use runner.run_cell for executing the current cell
        vim.cmd "MoltenNext" -- Move to the next Molten cell
      end, { buffer = true, desc = "Evaluate cell and go to the next one" })

      -- Run all cells
      vim.keymap.set(
        "n",
        "<C-S-CR>",
        function() runner.run_all(true) end,
        { desc = "run all cells of all languages", silent = true }
      )
    end,
  },
}
