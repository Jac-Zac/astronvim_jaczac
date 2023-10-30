-- Mapping data with "desc" stored directly by vim.key map.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the left-hand side of the map

    -- navigate buffer tabs with `H` and `L`
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>c"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Toggle comment line",
    },

    -- open markdown preview or latex depending on the file type
    ["<leader>m"] = {
      function()
        local file_extension = vim.fn.expand "%:e"
        if file_extension == "md" then
          vim.cmd "MarkdownPreview"
        elseif file_extension == "tex" then
          vim.cmd "VimtexCompile"
        end
      end,
      desc = "Open markdown preview or perform tex action",
    },

    --
    -- quick save
    ["<C-s>"] = { ":wq!<cr>", desc = "Save File" }, -- change description but the same command

    ["<F1>"] = { ":setlocal spell spelllang=en_us<CR>" },
    ["<F2>"] = { ":setlocal spell spelllang=it<CR>" },
    ["<F3>"] = { ":MarkdownPreview<CR>" },
    ["<F4>"] = { ":VimtexCompile<CR>" },

    -- disable the mapping
    ["<leader>/"] = false,

    -- fixing misspelled words
    ["f"] = { "[s1z=", desc = "Fixing misspelled backward" },
    ["F"] = { "]s1z=", desc = "Fixing misspelled forward" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },

  -- Visual mode
  v = {
    -- enable multiple line comments too
    ["<leader>c"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Toggle comment for selection",
    },
  },
}
