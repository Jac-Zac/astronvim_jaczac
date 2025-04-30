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
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = false, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
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
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        autochdir = true, -- automatically change directory to the one of the file
      },
      g = { -- vim.g.<key>
        python3_host_prog = vim.fn.expand "~/.config/python_libraries/virtualenvs/neovim/bin/python3",
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
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-s>"] = { ":wq!<cr>", desc = "Save File" }, -- change description but the same command

        --
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus

        -- Set up Function keys
        ["<F1>"] = {
          function()
            os.execute "cd ~/.config/nvim && git stash && git pull && git stash pop && cd"
            vim.cmd "MasonUpdate"
            vim.cmd "AstroUpdate"
            vim.cmd "Lazy update"
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

        [",m"] = {
          function()
            local file_extension = vim.fn.expand "%:e"
            if file_extension == "md" then
              vim.cmd "MarkdownPreview"
            elseif file_extension == "tex" then
              vim.cmd "VimtexCompile"
            elseif file_extension == "typ" then
              vim.cmd "TypstPreview"
            end
          end,
          desc = "Open markdown preview or perform tex action",
        },

        -- ["<Leader>a"] = {
        --   function()
        --     if vim.bo.filetype == "snacks_dashboard" then
        --       require("astrocore.buffer").close()
        --     else
        --       require("snacks").dashboard()
        --     end
        --   end,
        --   desc = "Home Screen",
        -- },

        -- Change some mappings to close buffers
        ["<Leader>bc"] = { function() require("astrocore.buffer").close() end, desc = "Close current buffer" },
        ["<Leader>bC"] = {
          function() require("astrocore.buffer").close_all(true) end,
          desc = "Close all buffers except current",
        },

        -- disabing mapping to close buffer
        ["<Leader>c"] = { "gcc", remap = true, desc = "Toggle comment line" },
        ["<Leader>/"] = false,

        -- Set zen model and line wrap --
        ["<Leader>uZ"] = {
          function()
            require("snacks").toggle.zen():toggle() -- Toggle Zen Mode
            require("astrocore.toggles").wrap() -- Toggle line wrap
            vim.cmd "LspStop"
          end,
          desc = "Toggle Folding and ZenMode",
        },

        ["<C-f>"] = { "[s1z=", desc = "Fixing misspelled backward" },

        -- OLd configs
        -- fixing misspelled words
        -- ["F"] = { "]s1z=", desc = "Fixing misspelled forward" },
        -- Select virtual environment
        -- ["<Leader>fv"] = { "<cmd>VenvSelect<CR>", desc = "Virtual environment selector" },
      },

      v = {
        -- enable multiple line comments too
        ["<Leader>c"] = { "gc", remap = true, desc = "Toggle comment" },
      },
    },
  },
}
