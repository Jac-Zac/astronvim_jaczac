-- Configuration for Obsidian Plugin
return {
  -- -- Obsidian
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  event = { "bufreadpre " .. vim.fn.expand "~" .. "/Documents/second_brain/**.md" },
  -- event = { "BufReadPre  */obsidian-vault/*.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
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

            ["<Leader>oq"] = { "<Cmd>ObsidianQuickSwitch<CR>", desc = "Search for words in Obsidian Notes" },
            ["<Leader>os"] = { "<Cmd>ObsidianSearch<CR>", desc = "Search files in Obsidian" },
            ["<Leader>oc"] = { "<Cmd>ObsidianToggleCheckbox<CR>", desc = "Obsidian Search" },
            ["<Leader>ol"] = { "<Cmd>ObsidianLinks<CR>", desc = "Show Obsidian Links" },
          },
          v = {
            ["<Leader>ol"] = { "<Cmd>ObsidianLink<CR>", desc = "Create an Obsidian Link" },
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