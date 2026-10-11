-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore", ---@type AstroCoreOpts
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
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- default off; enabled per-filetype via autocmds below (prose + comments)
        spelllang = "en_us,cjk",
        spelloptions = "camel",
        spellfile = vim.fn.stdpath "config" .. "/spell/en.utf-8.add",
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        autochdir = false, -- automatically change directory to the one of the file
        showtabline = 0, -- set to zero to avoid showing the tabline
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Custom autocmds: scoped spell checking (treesitter limits code buffers to @spell = comments/strings)
    autocmds = {
      enable_spell_prose = {
        {
          event = "FileType",
          pattern = { "markdown", "text", "plaintex", "tex", "typst", "gitcommit" },
          desc = "Enable spell for prose",
          callback = function() vim.opt_local.spell = true end,
        },
      },
      enable_spell_comments = {
        {
          event = "FileType",
          pattern = { "python", "lua", "cpp", "c", "sh", "bash", "zsh", "vim", "javascript", "typescript", "rust", "go" },
          desc = "Enable spell for code comments (treesitter @spell scopes it)",
          callback = function() vim.opt_local.spell = true end,
        },
      },
      disable_spell_special = {
        {
          event = "FileType",
          pattern = {
            "fyler",
            "help",
            "lazy",
            "mason",
            "neo-tree",
            "NvimTree",
            "TelescopePrompt",
            "TelescopeResults",
            "toggleterm",
          },
          desc = "Disable spell for tool windows",
          callback = function() vim.opt_local.spell = false end,
        },
      },
      -- Keep global diagnostic UI (underline/virtual_text) untouched;
      -- markdown LSP noise is filtered per-server instead. Only soften
      -- hint-level virtual text in prose so hints stay in floats.
      soften_markdown_hints = {
        {
          event = "FileType",
          pattern = { "markdown", "text" },
          desc = "Show only WARN+ inline in prose, hints stay in floats",
          callback = function(ev)
            vim.diagnostic.config({
              underline = { severity = { min = vim.diagnostic.severity.WARN } },
              virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
            }, ev.buf)
          end,
        },
      },
      -- Otter forwards symbols for the code fence at the cursor, not the whole document.
      disable_otter_symbols = {
        {
          event = "LspAttach",
          desc = "Disable Otter document symbols",
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name:match "^otter%-ls" then
              client.server_capabilities.documentSymbolProvider = nil
            end
          end,
        },
      },
    },
    -- Custom user commands
    commands = {
      FormatAll = {
        function()
          local ext = vim.fn.expand "%:e"
          if ext == "" then
            vim.notify("No file extension detected", vim.log.levels.WARN)
            return
          end

          local root = vim.fn.getcwd()
          local ok, astrocore = pcall(require, "astrocore")
          if ok and astrocore.rooter and astrocore.rooter.get_root then root = astrocore.rooter.get_root() or root end

          local pattern = "**/*." .. ext
          local files = vim.fn.glob(root .. "/" .. pattern, true, true)
          if #files == 0 then
            vim.notify("No *." .. ext .. " files found in project", vim.log.levels.WARN)
            return
          end

          vim.notify("Formatting " .. #files .. " *." .. ext .. " files...", vim.log.levels.INFO)
          for _, file in ipairs(files) do
            vim.cmd("edit " .. vim.fn.fnameescape(file))
            vim.lsp.buf.format({ async = false })
            vim.cmd "update"
          end
          vim.notify("Done formatting " .. #files .. " files", vim.log.levels.INFO)
        end,
        desc = "Format all files of current type in project",
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        ["<C-d>"] = { "<C-d>zz", desc = "Half page down, then center" },
        ["<C-u>"] = { "<C-u>zz", desc = "Half page up, then center" },

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

        -- Change some mappings to close buffers
        ["<Leader>bc"] = { function() require("astrocore.buffer").close() end, desc = "Close current buffer" },
        ["<Leader>bC"] = {
          function() require("astrocore.buffer").close_all(true) end,
          desc = "Close all buffers except current",
        },

        -- disabing mapping to close buffer
        ["<Leader>c"] = { "gcc", remap = true, desc = "Toggle comment line" },
        ["<Leader>/"] = false,

        -- Format all files of current type in project
        ["<Leader>F"] = {
          function() vim.cmd "FormatAll" end,
          desc = "Format all same-type files in project",
        },

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

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },

      v = {
        -- enable multiple line comments too
        ["<Leader>c"] = { "gc", remap = true, desc = "Toggle comment" },
      },
    },
  },
}
