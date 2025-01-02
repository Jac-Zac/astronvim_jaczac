---@type LazySpec
return {
  {
    "benlubas/molten-nvim",
    ft = { "quarto", "markdown" },
    -- event = "VeryLazy",
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
          opts.mappings.n[prefix] = { desc = "󱓞 Molten" }
          opts.mappings.n[prefix .. "l"] = { "<Cmd>MoltenEvaluateLine<CR>", desc = "Evaluate line" }
          opts.mappings.n[prefix .. "c"] = { "<Cmd>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" }
          opts.mappings.n[prefix .. "i"] = { "<Cmd>MoltenInit<CR>", desc = "Initialize the plugin" }
          opts.mappings.n[prefix .. "h"] = { "<Cmd>MoltenHideOutput<CR>", desc = "Hide Output" }
          opts.mappings.n[prefix .. "I"] = { "<Cmd>MoltenInterrupt<CR>", desc = "Interrupt Kernel" }
          opts.mappings.n[prefix .. "R"] =
            { "<Cmd>MoltenRestart<CR><Cmd>MoltenReevaluateAll<CR>", desc = "Restart Kernel and re-evaluate all" }

          -- Visual mode mappings
          opts.mappings.v[prefix] = { desc = "󱓞 Molten" }
          opts.mappings.v[prefix .. "r"] = { ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "Evaluate visual selection" }

          -- Navigation mappings for Molten Cells
          opts.mappings.n["]c"] = { "<Cmd>MoltenNext<CR>", desc = "Next Molten Cell" }
          opts.mappings.n["[c"] = { "<Cmd>MoltenPrev<CR>", desc = "Previous Molten Cell" }
        end,
      },
    },
    build = ":UpdateRemotePlugins",
    config = function()
      -- Molten settings
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
}
