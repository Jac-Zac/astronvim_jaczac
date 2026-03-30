return {
  "rareitems/printer.nvim",
  config = function()
    require("printer").setup {
      keymap = "gP", -- required by plugin, but you won't use it directly
      behavior = "insert_below",
      formatters = {
        python = function(inside, variable)
          -- inside = e.g. "[file.py:42]"
          -- result: print(f"[file.py:42] {var = }")
          return string.format('print(f"%s {%s = }")', inside, variable)
        end,
      },
      add_to_inside = function(text)
        -- e.g. "[path/to/file.py:42]"
        return string.format("[%s:%s]", vim.fn.expand "%", vim.fn.line ".")
      end,
    }

    -- Normal mode: gp always prints the big WORD under cursor
    vim.keymap.set("n", "gp", "<Plug>(printer_print)iW", { desc = "Printer: print WORD under cursor" })

    -- Visual mode: gp prints the current visual selection
    vim.keymap.set("x", "gp", "<Plug>(printer_print)", { desc = "Printer: print visual selection" })
  end,
}
