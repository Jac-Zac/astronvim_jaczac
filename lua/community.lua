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

  -- Markdown preview
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },

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
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = true,
        markdown = true,
        mason = true,
        native_lsp = { enabled = true },
        neotree = true,
        notify = true,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
        ts_rainbow = false,
        ufo = true,
        which_key = true,
        window_picker = true,
      },
    },
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
    opts = {
      modes = {
        -- Enable custom search
        search = {
          enabled = true,
        },
        char = {
          -- enabled = false,
          -- keys = { "f", "F", "t", "T", ";", "," },
          -- Keys remove the f and F since I use them for fixing spelling mistakes
          -- Following this instruction we map t to work like f [";"] = "L", [","] = H
          keys = { ["f"] = "t", ["F"] = "T", ";", "," },
        },
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
            auto_open = {
              enabled = false,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {}, -- merged with defaults from documentation
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          -- Set to false to make it appear in the center
          -- command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },

        -- Set the command line to the buttom
        -- Comment it to make it appear in the center
        cmdline = {
          view = "cmdline",
        },
      })
    end,
  },
}
