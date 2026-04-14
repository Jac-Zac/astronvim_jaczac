-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.typst" },
  { import = "astrocommunity.pack.markdown" },

  -- Python config
  -- Base pack with basedpyright, black and isort -> I will switch to ty instead of basedpyright
  -- { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.ty" },
  { import = "astrocommunity.pack.python.black" },
  { import = "astrocommunity.pack.python.isort" },

  -- Additional plugins
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  { import = "astrocommunity.debugging.nvim-dap-repl-highlights" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.motion.mini-ai" },
  { import = "astrocommunity.editing-support.undotree" },
  -- { import = "astrocommunity.media.img-clip-nvim" },

  -- AI completion
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.ai.sidekick-nvim" },

  -- Discover nice motions thanks to precognition-nvim
  -- { import = "astrocommunity.workflow.precognition-nvim" },

  -- Haed time nvim to improve vim efficiency
  -- { import = "astrocommunity.workflow.hardtime-nvim" },

  -- Additional might not be needed
  -- { import = "astrocommunity.test.neotest" },

  -- import/override with your plugins folder
}
