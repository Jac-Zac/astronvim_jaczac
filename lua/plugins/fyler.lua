return {
  "A7Lavinraj/fyler.nvim",
  dependencies = {
    "echasnovski/mini.icons",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        maps.n["<Leader>e"] = { "<Cmd>Fyler<CR>", desc = "Fyler" }
      end,
    },
  },
  cmd = "Fyler",
  opts = {
    -- Close explorer when file is selected
    -- close_on_select = true,
    -- close_on_select = false,

    -- Auto-confirm simple file operations
    confirm_simple = true,

    -- Replace as default explorer
    default_explorer = true,

    win = {
      border = "rounded",
      kind = "split_left",
    },

    git_status = {
      enabled = true,
      symbols = {
        Modified = "●",
        Added = "✚",
        Deleted = "✖",
        Untracked = "★",
      },
    },

    mappings = {
      ["<C-c>"] = "CloseView",
      ["<Tab>"] = "Select",
      ["s"] = "SelectVSplit",
      ["i"] = "SelectSplit",
    },

    indentscope = {
      marker = "┊",
    },
  },

  -- Additional configs
  -- specs = {
  --   { "neo-tree.nvim", optional = true, enabled = false },
  --   {
  --     "catppuccin",
  --     optional = true,
  --     ---@type CatppuccinOptions
  --     opts = { integrations = { mini = true } },
  --   },
  -- },
}
