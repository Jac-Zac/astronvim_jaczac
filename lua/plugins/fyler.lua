return {
  { "nvim-neo-tree/neo-tree.nvim", optional = true, enabled = false },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = {
      "echasnovski/mini.icons",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings or {}
          maps.n["<Leader>e"] = {
            function() require("fyler").toggle { kind = "float" } end,
            desc = "Open with fyler (floating)",
          }
        end,
      },
    },

    opts = {
      default_explorer = true,
      -- Close explorer when file is selected
      close_on_select = false,
      -- Move deleted files/directories to the system trash
      delete_to_trash = true,

      win = {
        border = "rounded",
        kind = "replace",
      },
      indentscope = {
        marker = "┊",
      },
    },
  },
}
