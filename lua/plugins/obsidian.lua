-- Configuration for Obsidian Plugin
-- Define prefix
local prefix = "<Leader>o"
return {
  -- -- Obsidian
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- Setting up obsidian to load even inside subdirectories of the value and inside the base directory
  -- event = {
  --   ft = { "markdown" },
  -- },
  --
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/second_brain/*.md",
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/second_brain/**/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = true,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = true,

        mappings = {
          n = {
            ["gf"] = {
              function()
                if require("obsidian").util.cursor_on_markdown_link() then
                  return "<Cmd>ObsidianFollowLink<CR>"
                else
                  return "gf"
                end
              end,
              desc = "Obsidian Follow Link",
            },

            [prefix] = { desc = "󱞁 Obsidian" }, -- Add an icon for the keybinding
            [prefix .. "f"] = { "<Cmd>ObsidianQuickSwitch<CR>", desc = "Search files in Obsidian" },
            [prefix .. "w"] = { "<Cmd>ObsidianSearch<CR>", desc = "Search word in Obsidian" },
            [prefix .. "c"] = { "<Cmd>ObsidianToggleCheckbox<CR>", desc = "Check Checkbox" },
            [prefix .. "l"] = { "<Cmd>ObsidianLinks<CR>", desc = "Show Obsidian Links" },
            [prefix .. "o"] = { "<Cmd>ObsidianOpen<CR>", desc = "Opens Obsidian Application" },
            [prefix .. "n"] = { "<Cmd>ObsidianNew<CR>", desc = "Create a new Note" },
            [prefix .. "t"] = { "<Cmd>ObsidianTemplate<CR>", desc = "Select a template" },
          },
          v = {
            [prefix .. "l"] = { "<Cmd>ObsidianLink<CR>", desc = "Create an Obsidian Link" },
          },
        },
      },
    },
  },
  opts = {
    -- dir = vim.env.HOME .. "/obsidian-vault", -- specify the vault location. no need to call 'vim.fn.expand' here
    dir = vim.env.HOME .. "/Documents/second_brain", -- specify the vault location. no need to call 'vim.fn.expand' here
    use_advanced_uri = true,
    finder = "telescope.nvim",

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or function(url) require("astrocore").system_open(url) end,
  },
}
