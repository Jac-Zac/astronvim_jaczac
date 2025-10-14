-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
--
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
