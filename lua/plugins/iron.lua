return {
  {
    "Vigemus/iron.nvim",
    ft = { "python" },

    config = function()
      local iron = require "iron.core"

      iron.setup {
        config = {
          -- Whether the repl buffer is a "throwaway" buffer or not
          scratch_repl = true,
          -- Automatically closes the repl window on process end
          close_window_on_exit = true,

          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
            python = {
              format = require("iron.fts.common").bracketed_paste,
              command = { "ipython", "-i", "--no-autoindent", "--nosep", " --quiet" },
              env = { PYTHON_BASIC_REPL = "1" }, --this is needed for python3.13 and up.
              block_dividers = { "# %%", "#%%" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").split.vertical.botright(0.40, {
            winfixwidth = false,
            winfixheight = false,
            number = false,
          }),
        },
        keymaps = {
          clear = "<leader>rc",
          send_code_block_and_move = "<C-CR>",
        },

        -- If the highlight is on, you can change how it looks
        -- For the available options, check `:help nvim_set_hl`
        highlight = { italic = true }, -- make code that was just sent italic
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands
      -- from outside REPL only
      vim.keymap.set(
        "n",
        "<leader>rr",
        function() iron.repl_for(vim.bo.filetype) end,
        { desc = "REPL: start/toggle/hide (from code buffer)" }
      )

      -- vim.keymap.set("n", "<leader>rc", iron.clear, { desc = "REPL: clear (from code buffer)" })
      -- vim.keymap.set("n", "<C-CR>", iron.send_code_block, { desc = "Send Code Block" })

      vim.keymap.set("n", "<leader>rl", iron.send_line, { desc = "Run line" })
      vim.keymap.set("n", "<leader>rp", iron.send_paragraph, { desc = "Run paragraph" })
      vim.keymap.set("n", "<leader>ru", iron.send_until_cursor, { desc = "Run until cursor" })
      vim.keymap.set("n", "<leader>rf", iron.send_file, { desc = "Run file" })

      -- visual mode
      vim.keymap.set("v", "<C-CR>", iron.visual_send, { desc = "Run selection" })
    end,
  },
}
