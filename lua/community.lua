-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.typst" },
  { import = "astrocommunity.pack.markdown" },

  -- Additional plugins
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.media.img-clip-nvim" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.file-explorer.mini-files" },
  { import = "astrocommunity.editing-support.undotree" },

  -- Discover nice motions thanks to precognition-nvim
  -- { import = "astrocommunity.workflow.precognition-nvim" },

  -- Haed time nvim to improve vim efficiency
  -- { import = "astrocommunity.workflow.hardtime-nvim" },

  -- Additional might not be needed
  -- { import = "astrocommunity.test.neotest" },

  -- Import additional packages
  -- https://github.com/azratul/live-share.nvim -- Useful to share sessions

  -- Runs privately
  -- { import = "astrocommunity.motion.mini-surround" },

  -- import/override with your plugins folder
}
