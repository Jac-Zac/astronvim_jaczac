-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==
  -- Configure to view images automatically
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      -- In the future enable images in a smart way that isn't annoying
      -- image = {
      --   doc = {
      --     enabled = false,
      --     -- enabled = true,
      --     -- Only show the image when hovering over it
      --     inline = false,
      --   },
      --   float = false,
      --   -- float = true,
      -- },

      zen = {
        toggles = {
          dim = true,
        },
      },
      dim = {
        ---@type snacks.animate.Config|{enabled?: boolean}
        animate = {
          duration = {
            step = 0, -- ms per step
            total = 0, -- maximum duration
          },
        },
      },
    },
  },

  -- customize dashboard options:lua Snacks.dashboard(
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,

    init = function()
      -- local colors = require("catppuccin.palettes").get_palette()
      local colors = require("nightfox.palette").load "nordfox"
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = colors.blue.base })
      vim.api.nvim_set_hl(0, "SnacksDashboardProject", { fg = colors.yellow.base })
      vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = colors.yellow.base })
      vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = colors.green.base })
      vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = colors.cyan.base })
      vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = colors.orange.base })
    end,
    opts = function(_, opts)
      local get_icon = require("astroui").get_icon

      opts.dashboard = {
        preset = {
          header = table.concat({
            "            *            *     ,MMM8&&&.            *          .        ",
            "       .                      MMMM88&&&&&,    .                         ",
            "                 *           MMM88&&&&&&&&                *      .      ",
            "   .                         MMM88&&&&&&&&          .                 . ",
            "        .             .      'MMM88&&&&&&'                   .          ",
            "                               'MMM8&&&'          *                     ",
            "            .                .                          .         *     ",
            "   .               *                         *                          ",
            "                                 .                       *      .       ",
            "         *          /^--^\\     /^--^\\     /^--^\\                  .  ",
            "                 .  \\____/     \\____/     \\____/        .            ",
            "    .              /      \\   /      \\   /      \\                    ",
            "           .        |        | |        | |        |           .        ",
            "                   \\__  __/   \\__  __/   \\__  __/                    ",
            "|^|^|^|^|^|^|^|^|^|^|^|^\\ \\^|^|^|^/ /^|^|^|^|^\\ \\^|^|^|^|^|^|^|^|^|^|^|^|",
            "| | | | | | | | | | | | |\\ \\| | |/ /| | | | | |\\ \\| | | | | | | | | | | |",
            "#########################/ /#####\\ \\###########/ /#######################",
            "| | | | | | | | | | | | |\\/| | | |\\/| | | | | |\\/ | | | | | | | | | | | |",
            "|_|_|_|_|_|_|_|_|_| Jac Zac Custom AstroNvim config |_|_|_|_|_|_|_|_|_|_|",
          }, "\n"),

          keys = {
            { key = "o", action = "<Leader>fo", icon = get_icon("DefaultFile", 0, true), desc = "Recents  " },
            -- { key = "'", action = "<Leader>ht", icon = get_icon("Bookmarks", 0, true), desc = "Harpooon  " },
            { key = "p", action = "<Leader>fp", icon = get_icon("FolderOpen", 0, true), desc = "Find Project  " },
            { key = "w", action = "<Leader>fw", icon = get_icon("WordFile", 0, true), desc = "Find Word  " },
            { key = "f", action = "<Leader>ff", icon = get_icon("Search", 0, true), desc = "Find File  " },
            { key = "s", action = "<Leader>Sl", icon = get_icon("Refresh", 0, true), desc = "Last Session  " },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          {
            -- pane = 2,
            icon = " ",
            desc = "Browse Repo",
            padding = 3,
            key = "b",
            action = function() Snacks.gitbrowse() end,
          },
          -- { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, pane = 2 },
          -- {
          --   -- pane = 2,
          --   icon = " ",
          --   title = "Git Status",
          --   section = "terminal",
          --   enabled = function() return Snacks.git.get_root() ~= nil end,
          --   cmd = "git status --short --branch --renames",
          --   height = 5,
          --   padding = 1,
          --   ttl = 5 * 60,
          --   indent = 3,
          -- },
          { section = "startup" },
        },
      }
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
  -- { "nvim-neo-tree/neo-tree.nvim", enabled = false }, -- Disabled inside mini.files

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },

  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
}
