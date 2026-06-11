return {
  {
    "Vigemus/iron.nvim",
    dir = "/Users/jaczac/Github/iron.nvim", -- your patched local checkout
    ft = { "python", "markdown" },

    config = function()
      local iron = require "iron.core"
      local common = require "iron.fts.common"

      local python_repl = {
        format = common.bracketed_paste,
        command = {
          "ipython",
          "-i",
          "--no-autoindent",
          "--nosep",
          "--quiet",
          "--no-confirm-exit",
          "--no-tip",
          "--no-banner",
        },
        env = { PYTHON_BASIC_REPL = "1" }, -- this is needed for python3.13 and up.
        block_dividers = { "# %%", "#%%", "```python" },
      }

      local function remote_shell_def(command)
        return {
          command = command,
          format = common.bracketed_paste,
        }
      end

      local function send_jupytext_cell()
        if vim.bo.filetype ~= "markdown" then return iron.send_code_block(true) end

        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

        local function is_python_fence(line)
          return line and (line:match "^```%s*[pP][yY][tT][hH][oO][nN]" or line:match "^```%s*[pP][yY][%w_%-]*")
        end

        local function is_closing_fence(line) return line and line:match "^```%s*$" ~= nil end

        local cells = {}
        local open_line
        for i, line in ipairs(lines) do
          if not open_line and is_python_fence(line) then
            open_line = i
          elseif open_line and is_closing_fence(line) then
            table.insert(cells, { start = open_line, finish = i })
            open_line = nil
          end
        end

        local cell
        for _, current in ipairs(cells) do
          if cursor_line <= current.finish then
            cell = current
            break
          end
        end

        if not cell or cell.finish <= cell.start then return iron.send_code_block(true) end

        local cell_lines = vim.list_slice(lines, cell.start + 1, cell.finish - 1)
        if #cell_lines == 0 then return iron.send_code_block(true) end

        iron.send(nil, cell_lines)

        local next_cell
        for _, candidate in ipairs(cells) do
          if candidate.start > cell.start then
            next_cell = candidate
            break
          end
        end

        if next_cell then
          vim.api.nvim_win_set_cursor(0, { math.min(next_cell.start + 1, #lines), 0 })
        else
          vim.api.nvim_win_set_cursor(0, { math.min(cell.finish + 1, #lines), 0 })
        end
      end

      local function read_ssh_hosts()
        local path = vim.fn.expand "~/.ssh/config"
        if vim.fn.filereadable(path) == 0 then return {} end

        local hosts, seen = {}, {}
        for _, line in ipairs(vim.fn.readfile(path)) do
          line = line:gsub("#.*$", "")
          local host_list = line:match "^%s*[Hh][Oo][Ss][Tt]%s+(.+)$"
          if host_list then
            for host in host_list:gmatch "%S+" do
              if
                host ~= "*"
                and host ~= "?"
                and not host:match "^[%!].*"
                and not host:find "[%*%?]"
                and not seen[host]
              then
                seen[host] = true
                table.insert(hosts, host)
              end
            end
          end
        end

        table.sort(hosts)
        return hosts
      end

      local function build_remote_shell_command(choice, done)
        local hosts = read_ssh_hosts()
        if choice == "Custom SSH command" then
          vim.ui.input({
            prompt = "SSH command",
          }, function(cmdline)
            if cmdline == nil or vim.trim(cmdline) == "" then return end

            if not cmdline:match "^%s*ssh%s" then cmdline = "ssh " .. cmdline end

            done { "sh", "-lc", "exec " .. cmdline }
          end)
          return
        end

        done { "ssh", choice }
      end

      local function start_remote_shell()
        local bufnr = vim.api.nvim_get_current_buf()
        local hosts = read_ssh_hosts()
        table.insert(hosts, 1, "Custom SSH command")

        vim.ui.select(hosts, { prompt = "SSH target" }, function(choice)
          if not choice then return end

          build_remote_shell_command(choice, function(command)
            require("iron.config").repl_definition.remote_shell = remote_shell_def(command)
            iron.attach("remote_shell", bufnr)
          end)
        end)
      end

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
            python = python_repl,
            markdown = python_repl,
            remote_shell = remote_shell_def { "ssh" },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").split.vertical.botright(0.40, {
            winfixwidth = false,
            winfixheight = false,
            number = false,
          }),
          -- vim.api.nvim_set_hl(0, "IronCellMarker", { fg = "#ff5f87", bold = true }),
          cell_marker = {
            enabled = true,
          },
          ignore_blank_lines = true,
        },
        keymaps = {
          clear = "<leader>rc",
          send_code_block_and_move = "<C-CR>",
        },

        -- If the highlight is on, you can change how it looks
        -- For the available options, check `:help nvim_set_hl`
        highlight = { bg = "#434c5e" },
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
      vim.keymap.set("n", "<leader>rR", start_remote_shell, { desc = "REPL: start and attach remote shell (SSH)" })
      vim.keymap.set(
        "n",
        "<leader>rC",
        function() iron.close_repl(vim.bo.filetype) end,
        { desc = "REPL: close (from code buffer)" }
      )

      vim.keymap.set("n", "<leader>rl", iron.send_line, { desc = "Run line" })
      vim.keymap.set("n", "<leader>rp", iron.send_paragraph, { desc = "Run paragraph" })
      vim.keymap.set("n", "<leader>ru", iron.send_until_cursor, { desc = "Run until cursor" })
      vim.keymap.set("n", "<leader>rf", iron.send_file, { desc = "Run file" })
      vim.keymap.set("n", "<C-CR>", send_jupytext_cell, { desc = "Run markdown cell without fences" })

      ---- from inside REPL only
      vim.keymap.set("n", "<leader>rX", iron.repl_restart, { desc = "REPL: restart (from inside REPL)" })

      -- visual mode
      vim.keymap.set("v", "<C-CR>", iron.visual_send, { desc = "Run selection" })
    end,
  },

  {
    "jmbuhr/otter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    config = function()
      local otter = require "otter"

      -- Keep Python LSP features available inside Jupytext markdown cells.
      otter.setup {}

      local group = vim.api.nvim_create_augroup("otter-jupytext", { clear = true })
      local function activate_otter(bufnr)
        if vim.bo[bufnr].filetype ~= "markdown" then return end
        if vim.b[bufnr].otter_jupytext_active then return end
        vim.defer_fn(function()
          if not vim.api.nvim_buf_is_valid(bufnr) then return end

          local ok, err = pcall(vim.api.nvim_buf_call, bufnr, function()
            local success, activate_err = pcall(otter.activate, nil, true, true)
            if not success then error(activate_err) end
          end)

          if ok then
            vim.b[bufnr].otter_jupytext_active = true
          else
            vim.notify("otter activation failed: " .. tostring(err), vim.log.levels.WARN)
          end
        end, 50)
      end

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
        group = group,
        pattern = "markdown",
        callback = function(ev) activate_otter(ev.buf) end,
      })

      activate_otter(vim.api.nvim_get_current_buf())
    end,
  },
}
