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
            os.execute "cd ~/.config/nvim && git stash && git pull && git stash pop && cd"
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

        [",m"] = {
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

        ["<Leader>tr"] = {
          function()
            -- Automatically save the current file before running any command
            vim.cmd "update" -- This will save the current buffer if it has been modified

            local file_name = vim.fn.expand "%:t"
            local file_type = vim.fn.expand "%:e"
            local executable_name = vim.fn.expand "%:t:r"

            local function compile_and_run(compile_cmd, run_cmd) return string.format("%s && %s", compile_cmd, run_cmd) end

            local function interpret(interpreter) return string.format("%s %s", interpreter, file_name) end

            local function add_header_and_clear(cmd)
              -- Clear the terminal and add a custom header
              return string.format("clear && echo '==== Running your code ====' && %s", cmd)
            end

            local commands = {
              c = function()
                return compile_and_run("gcc " .. file_name .. " -o " .. executable_name, "./" .. executable_name)
              end,
              cpp = function()
                return compile_and_run("g++ " .. file_name .. " -o " .. executable_name, "./" .. executable_name)
              end,
              py = function() return interpret "python3" end,
              js = function() return interpret "node" end,
              lua = function() return interpret "lua" end,
              java = function() return compile_and_run("javac " .. file_name, "java " .. executable_name) end,
              go = function() return interpret "go run" end,
              rust = function() return compile_and_run("rustc " .. file_name, "./" .. executable_name) end,
            }

            local cmd = commands[file_type]
            if cmd then
              -- Clear the terminal first and then run the command
              -- require("toggleterm").exec(add_header_and_clear(cmd()), 1, 12, nil, "float")
              require("toggleterm").exec(add_header_and_clear(cmd()), 12, 60, nil, "vertical")
            else
              vim.notify("No command defined for file type: " .. file_type, vim.log.levels.WARN)
            end
          end,
          desc = "Compile and run current file",
        },

        -- Select virtual environment
        ["<Leader>fv"] = { "<cmd>VenvSelect<CR>", desc = "Virtual environment selector" },

        -- disable the mapping
        ["<Leader>/"] = false, -- disabling for comment
        ["<Leader>a"] = { "<cmd>Alpha<CR>", desc = "Open Alpha Dashboard" },

        -- fixing misspelled words
        ["F"] = { "]s1z=", desc = "Fixing misspelled forward" },
        ["f"] = { "[s1z=", desc = "Fixing misspelled backward" },
        --
        -- ["<C-F>"] = { "[s1z=", desc = "Fixing misspelled backward" },
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
