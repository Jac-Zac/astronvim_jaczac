return {
  "rebelot/heirline.nvim",
  dependencies = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {},
    },
  },
  opts = function(_, opts)
    local status = require "astroui.status"

    -- Your existing statusline (bottom bar)
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      },
      status.component.file_info {
        filename = { fallback = "Empty" },
        padding = { right = 1 },
        filetype = false,
        file_read_only = false,
      },
      status.component.git_branch(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
    }

    -- Add winbar (only show when there are splits)
    opts.winbar = {
      fallthrough = false,
      {
        condition = function()
          -- Count only normal windows (exclude special buffers like NeoTree, etc.)
          local normal_wins = 0
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buftype = vim.bo[buf].buftype
            local filetype = vim.bo[buf].filetype
            -- Only count windows with normal buffers (not special windows)
            if buftype == "" and filetype ~= "neo-tree" then normal_wins = normal_wins + 1 end
          end
          return normal_wins > 1
        end,
        status.component.file_info {
          filename = { padding = { right = 1 } },
          file_icon = { padding = { left = 1, right = 1 } },
          file_modified = { padding = { left = 0, right = 1 } },
          filetype = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbar", true),
        },
      },
    }
  end,
}
