-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
--

local markdown_preview_app = vim.fn.stdpath "data" .. "/lazy/markdown-preview.nvim/app"

local function markdown_preview_missing_deps()
  return vim.fn.filereadable(markdown_preview_app .. "/node_modules/tslib/tslib.js") == 0
end

if markdown_preview_missing_deps() and vim.fn.executable "npm" == 1 then
  vim.fn.system("cd " .. vim.fn.shellescape(markdown_preview_app) .. " && npm install")
end

-- Disable spell checking for Toggle Term
vim.api.nvim_command "autocmd TermOpen * setlocal nospell"

-- Disable spell checking for Fyler
vim.api.nvim_command "autocmd FileType fyler setlocal nospell"

-- Automatic fold peeking with delay
-- vim.api.nvim_create_autocmd("CursorMoved", {
--   pattern = "*",
--   callback = function()
--     vim.defer_fn(function() require("ufo").peekFoldedLinesUnderCursor() end, 100) -- 100ms delay
--   end,
-- })

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
