---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      ensure_installed = {
        "lua",
        "vim",
        "python",
        "cpp",
        "latex",
        "json",
      },
    },
  },
}
