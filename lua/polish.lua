-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
--
-- Disable spell checking for Toggle Term
vim.api.nvim_command "autocmd TermOpen * setlocal nospell"

-- Automatically change directory when switching to a file buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    -- Only run if the buffer is a normal file
    if vim.bo.buftype == "" then
      local dir = vim.fn.expand "%:p:h"
      if dir ~= vim.fn.getcwd() then vim.cmd("cd " .. dir) end
    end
  end,
})

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
