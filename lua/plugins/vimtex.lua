return {
  "lervag/vimtex",

  init = function()
    -- Set the build directory to .tex_build
    vim.g.vimtex_compiler_latexmk = {
      out_dir = ".tex_build", -- Compilation output in .tex_build directory
      continuous = 1, -- Enable continuous mode for live updates
      executable = "latexmk", -- Use latexmk for compiling
      options = {
        "-pdf", -- Generate PDF
        "-pvc", -- continuous compilation
        "-interaction=nonstopmode", -- Compile in nonstop mode
        "-synctex=1", -- Enable SyncTeX for PDF sync
      },
    }

    -- Set Biber as the bibliography backend
    vim.g.Tex_CompileRule_pdf = "arara -v $*"

    -- Configure Skim as the PDF viewer
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_sync = 1 -- SyncTeX enabled for Skim
    vim.g.vimtex_view_skim_activate = 1 -- Auto-activate Skim on view

    -- Disable VimTeX syntax highlighting (use Tree-sitter instead)
    vim.g.vimtex_syntax_enabled = 0

    -- Disable VimTeX quickfix auto-open
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- -- Use nvim-notify for error and warning notifications only
    -- vim.cmd [[
    --     autocmd User VimtexEventCompileFailed lua require("notify")("Compilation error detected!", "error")
    --     autocmd User VimtexEventCompileWarning lua require("notify")("Compilation completed with warnings!", "warn")
    -- ]]

    -- Auto-save on CursorHold to trigger continuous compilation
    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "*.tex",
      command = "silent! update",
    })
  end,

  lazy = false,
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        vimtex_mapping_descriptions = {
          {
            event = "FileType",
            desc = "Set up VimTex Which-Key descriptions",
            pattern = "tex",
            callback = function(event)
              local wk_avail, wk = pcall(require, "which-key")
              if not wk_avail then return end
              wk.add {
                buffer = event.buf,
                {
                  mode = "n",
                  { "<localleader>l", group = "VimTeX" },
                  { "<localleader>la", desc = "Show Context Menu" },
                  { "<localleader>lC", desc = "Full Clean" },
                  { "<localleader>lc", desc = "Clean" },
                  { "<localleader>le", desc = "Show Errors" },
                  { "<localleader>lG", desc = "Show Status for All" },
                  { "<localleader>lg", desc = "Show Status" },
                  { "<localleader>li", desc = "Show Info" },
                  { "<localleader>lI", desc = "Show Full Info" },
                  { "<localleader>lk", desc = "Stop VimTeX" },
                  { "<localleader>lK", desc = "Stop All VimTeX" },
                  { "<localleader>lL", desc = "Compile Selection" },
                  { "<localleader>ll", desc = "Compile" },
                  { "<localleader>lm", desc = "Show Imaps" },
                  { "<localleader>lo", desc = "Show Compiler Output" },
                  { "<localleader>lq", desc = "Show VimTeX Log" },
                  { "<localleader>ls", desc = "Toggle Main" },
                  { "<localleader>lt", desc = "Open Table of Contents" },
                  { "<localleader>lT", desc = "Toggle Table of Contents" },
                  { "<localleader>lv", desc = "View Compiled Document" },
                  { "<localleader>lX", desc = "Reload VimTeX State" },
                  { "<localleader>lx", desc = "Reload VimTeX" },
                },
                {
                  mode = "o",
                  { "ic", desc = "LaTeX Command" },
                  { "ac", desc = "LaTeX Command" },
                },
              }
            end,
          },
        },
      },
    },
  },
}
