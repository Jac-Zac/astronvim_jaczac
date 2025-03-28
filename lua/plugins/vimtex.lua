---@type LazySpec
return {
  "lervag/vimtex",
  ft = { "tex" },
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

  -- lazy = true,
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
                  { "<LocalLeader>l", group = "VimTeX" },
                  { "<LocalLeader>la", desc = "Show Context Menu" },
                  { "<LocalLeader>lC", desc = "Full Clean" },
                  { "<LocalLeader>lc", desc = "Clean" },
                  { "<LocalLeader>le", desc = "Show Errors" },
                  { "<LocalLeader>lG", desc = "Show Status for All" },
                  { "<LocalLeader>lg", desc = "Show Status" },
                  { "<LocalLeader>li", desc = "Show Info" },
                  { "<LocalLeader>lI", desc = "Show Full Info" },
                  { "<LocalLeader>lk", desc = "Stop VimTeX" },
                  { "<LocalLeader>lK", desc = "Stop All VimTeX" },
                  { "<LocalLeader>lL", desc = "Compile Selection" },
                  { "<LocalLeader>ll", desc = "Compile" },
                  { "<LocalLeader>lm", desc = "Show Imaps" },
                  { "<LocalLeader>lo", desc = "Show Compiler Output" },
                  { "<LocalLeader>lq", desc = "Show VimTeX Log" },
                  { "<LocalLeader>ls", desc = "Toggle Main" },
                  { "<LocalLeader>lt", desc = "Open Table of Contents" },
                  { "<LocalLeader>lT", desc = "Toggle Table of Contents" },
                  { "<LocalLeader>lv", desc = "View Compiled Document" },
                  { "<LocalLeader>lX", desc = "Reload VimTeX State" },
                  { "<LocalLeader>lx", desc = "Reload VimTeX" },
                  { "ts", group = "VimTeX Toggles & Cycles" },
                  { "ts$", desc = "Cycle inline, display & numbered equation" },
                  { "tsc", desc = "Toggle star of command" },
                  { "tsd", desc = "Cycle (), \\left(\\right) [,...]" },
                  { "tsD", desc = "Reverse Cycle (), \\left(\\right) [, ...]" },
                  { "tse", desc = "Toggle star of environment" },
                  { "tsf", desc = "Toggle a/b vs \\frac{a}{b}" },
                  { "[/", desc = "Previous start of a LaTeX comment" },
                  { "[*", desc = "Previous end of a LaTeX comment" },
                  { "[[", desc = "Previous beginning of a section" },
                  { "[]", desc = "Previous end of a section" },
                  { "[m", desc = "Previous \\begin" },
                  { "[M", desc = "Previous \\end" },
                  { "[n", desc = "Previous start of a math zone" },
                  { "[N", desc = "Previous end of a math zone" },
                  { "[r", desc = "Previous \\begin{frame}" },
                  { "[R", desc = "Previous \\end{frame}" },
                  { "]/", desc = "Next start of a LaTeX comment %" },
                  { "]*", desc = "Next end of a LaTeX comment %" },
                  { "][", desc = "Next beginning of a section" },
                  { "]]", desc = "Next end of a section" },
                  { "]m", desc = "Next \\begin" },
                  { "]M", desc = "Next \\end" },
                  { "]n", desc = "Next start of a math zone" },
                  { "]N", desc = "Next end of a math zone" },
                  { "]r", desc = "Next \\begin{frame}" },
                  { "]R", desc = "Next \\end{frame}" },
                  { "csc", desc = "Change surrounding command" },
                  { "cse", desc = "Change surrounding environment" },
                  { "cs$", desc = "Change surrounding math zone" },
                  { "csd", desc = "Change surrounding delimiter" },
                  { "dsc", desc = "Delete surrounding command" },
                  { "dse", desc = "Delete surrounding environment" },
                  { "ds$", desc = "Delete surrounding math zone" },
                  { "dsd", desc = "Delete surrounding delimiter" },
                },
                {
                  mode = "o",
                  { "ic", desc = "LaTeX Command" },
                  { "ac", desc = "LaTeX Command" },
                  { "id", desc = "LaTeX Math Delimiter" },
                  { "ad", desc = "LaTeX Math Delimiter" },
                  { "ie", desc = "LaTeX Environment" },
                  { "ae", desc = "LaTeX Environment" },
                  { "i$", desc = "LaTeX Math Zone" },
                  { "a$", desc = "LaTeX Math Zone" },
                  { "iP", desc = "LaTeX Section, Paragraph, ..." },
                  { "aP", desc = "LaTeX Section, Paragraph, ..." },
                  { "im", desc = "LaTeX Item" },
                  { "am", desc = "LaTeX Item" },
                },
              }
            end,
          },
        },
      },
    },
  },
}
