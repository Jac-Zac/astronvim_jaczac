-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  --
  { import = "astrocommunity.pack.python" },

  -- Nord theme
  {
    "EdenEast/nightfox.nvim",
    opts = {
      integrations = { noice = true },
      options = {
        module_default = false,
        modules = {
          aerial = true,
          cmp = true,
          ["dap-ui"] = true,
          dashboard = true,
          diagnostic = true,
          gitsigns = true,
          native_lsp = true,
          neotree = true,
          notify = true,
          symbol_outline = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
        },
      },
      groups = { all = { NormalFloat = { link = "Normal" } } },
    },
  },

  -- Catpuccino theme
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { noice = true } },
  },

  -- Import flash for better movement
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            x = {
              ["s"] = {
                function() require("flash").jump() end,
                desc = "Flash",
              },
              ["R"] = {
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search",
              },
              ["S"] = {
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
              },
            },
            o = {
              ["r"] = {
                function() require("flash").remote() end,
                desc = "Remote Flash",
              },
              ["R"] = {
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search",
              },
              ["s"] = {
                function() require("flash").jump() end,
                desc = "Flash",
              },
              ["S"] = {
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
              },
            },
            n = {
              ["s"] = {
                function() require("flash").jump() end,
                desc = "Flash",
              },
              ["S"] = {
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
              },
            },
          },
        },
      },
    },
    opts = {},
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   },
  -- },

  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = function(_, opts)
  --     local utils = require "astrocore"
  --     return utils.extend_tbl(opts, {
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         -- override = {
  --         --   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         --   ["vim.lsp.util.stylize_markdown"] = true,
  --         --   ["cmp.entry.get_documentation"] = true,
  --         -- },
  --       },
  --       presets = {
  --         -- bottom_search = true, -- use a classic bottom cmdline for search
  --         -- command_palette = true, -- position the cmdline and popupmenu together
  --         -- long_message_to_split = true, -- long messages will be sent to a split
  --         -- inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
  --         -- lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --     })
  --   end,
  -- },
}
