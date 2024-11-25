-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      -- add any language you might be interested in
      "lua",
      "vim",
      "python",
      "cpp",
      "latex",
      "jsonc",
      -- add more arguments for adding more treesitter parsers
    })
  end,
}
