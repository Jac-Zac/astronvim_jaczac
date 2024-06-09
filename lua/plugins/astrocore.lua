-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = true, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        conceallevel = 2, --set concelelevel to the max
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthnd side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>c"] = {
          function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Toggle comment line",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        -- quick save
        ["<C-s>"] = { ":wq!<cr>", desc = "Save File" }, -- change description but the same command

        -- Set up Function keys
        ["<F1>"] = {
          function()
            os.execute "cd ~/.config/nvim && git pull && cd"
            vim.cmd "AstroUpdate"
          end,
          desc = "Update AstroNvim",
        },

        ["<F2>"] = { "<cmd>NoiceDismiss<CR>", desc = "Dismiss Noice Messages" },
        ["<F3>"] = { "<cmd>TodoTelescope<CR>", desc = "Todo Search with Telescope" },
        -- open markdown preview or latex depending on the file type
        ["<F4>"] = {
          function()
            local file_extension = vim.fn.expand "%:e"
            if file_extension == "md" then
              vim.cmd "MarkdownPreview"
            elseif file_extension == "tex" then
              vim.cmd "VimtexCompile"
            end
          end,
          desc = "Open markdown preview or perform tex action",
        },

        -- Select virtual environment
        ["<Leader>fv"] = { "<cmd>VenvSelect<CR>", desc = "Virtual environment selector" },

        -- disable the mapping
        ["<Leader>/"] = false, -- disabling for comment
        ["<Leader>o"] = false, -- disabling for obsidian
        ["<Leader>h"] = false, -- disabling it for harpoon
        ["<Leader>a"] = { "<cmd>Alpha<CR>", desc = "Open Alpha Dashboard" },

        -- fixing misspelled words
        -- ["f"] = { "]s1z=", desc = "Fixing misspelled forward" },
        -- ["F"] = { "[s1z=", desc = "Fixing misspelled backward" },
        --
        ["<C-F>"] = { "[s1z=", desc = "Fixing misspelled backward" },
        -- ["<C-S-F>"] = { "]s1z=", desc = "Fixing misspelled forward" },
      },
      t = {
        -- setting a mapping to false will disable it
      },
      -- Visual mode
      v = {
        -- enable multiple line comments too
        ["<Leader>c"] = {
          "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
          desc = "Toggle comment for selection",
        },
      },
    },
  },
}
