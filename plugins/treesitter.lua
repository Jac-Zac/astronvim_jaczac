return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {

      -- add any language you might be interested in
      "lua",
      "python",
      "cpp",
      "latex",
    })
  end,
}
