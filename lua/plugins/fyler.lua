return {
  { "nvim-neo-tree/neo-tree.nvim", optional = true, enabled = false },
  {
    "FylerOrg/fyler.nvim",
    version = "^2",
    dependencies = {
      "nvim-mini/mini.icons",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings or {}
          opts.mappings = maps
          maps.n = maps.n or {}
          maps.n["<Leader>e"] = {
            function() require("fyler").toggle { kind = "float" } end,
            desc = "Open with fyler (floating)",
          }

          -- --- ADDITION STARTS HERE ---
          -- We create an autocommand to run whenever the 'fyler' filetype is detected.
          opts.autocmds = opts.autocmds or {}
          opts.autocmds.fyler_unmap_q = {
            {
              event = "FileType",
              pattern = "fyler", -- This assumes the filetype is 'fyler'. Check :set ft? if unsure.
              callback = function(args)
                -- pcall prevents errors if 'q' isn't mapped for some reason
                pcall(vim.keymap.del, "n", "q", { buffer = args.buf })
              end,
            },
          }
          -- --- ADDITION ENDS HERE ---
        end,
      },
    },

    opts = {
      integrations = {
        icon = "mini_icons",
      },

      views = {
        finder = {
          default_explorer = true,
          close_on_select = false,
          win = {
            border = "rounded",
            kind = "replace",
            win_opts = {
              number = true,
              relativenumber = true,
            },
          },
        },
      },
    },
  },
}
