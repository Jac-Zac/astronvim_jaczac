---@type LazySpec
return {
  {
    "benlubas/molten-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "3rd/image.nvim",
      "GCBallesteros/jupytext.nvim",
      {
        "AstroNvim/astroui",
        opts = { icons = { Molten = "󱓞" } },
      },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          if not opts.mappings then opts.mappings = {} end
          local prefix = "<leader>m"

          -- Normal mode mappings
          opts.mappings.n[prefix .. "e"] = { "<Cmd>MoltenEvaluateOperator<CR>", desc = "Run operator selection" }
          opts.mappings.n[prefix .. "l"] = { "<Cmd>MoltenEvaluateLine<CR>", desc = "Evaluate line" }
          opts.mappings.n[prefix .. "c"] = { "<Cmd>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" }
          opts.mappings.n[prefix .. "i"] = { "<Cmd>MoltenInit<CR>", desc = "Initialize the plugin" }
          opts.mappings.n[prefix .. "h"] = { "<Cmd>MoltenHideOutput<CR>", desc = "Hide Output" }
          opts.mappings.n[prefix .. "I"] = { "<Cmd>MoltenInterrupt<CR>", desc = "Interrupt Kernel" }
          opts.mappings.n[prefix .. "R"] = { "<Cmd>MoltenRestart<CR>", desc = "Restart Kernel" }

          -- Visual mode mappings
          opts.mappings.v[prefix] = { desc = require("astroui").get_icon("Molten", 1, true) .. "Molten" }
          opts.mappings.v[prefix .. "r"] = { ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Evaluate visual selection" }

          -- Navigation mappings for Molten Cells
          opts.mappings.n["]c"] = { "<Cmd>MoltenNext<CR>", desc = "Next Molten Cell" }
          opts.mappings.n["[c"] = { "<Cmd>MoltenPrev<CR>", desc = "Previous Molten Cell" }
        end,
      },
    },
    build = ":UpdateRemotePlugins",
  },
}
