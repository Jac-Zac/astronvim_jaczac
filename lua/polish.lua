-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
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

-- Automatic fold peeking with delay
vim.api.nvim_create_autocmd("CursorMoved", {
  pattern = "*",
  callback = function()
    vim.defer_fn(function() require("ufo").peekFoldedLinesUnderCursor() end, 100) -- 100ms delay
  end,
})

-- local kernel_initialized = false
--
-- -- Search kernel
-- local function ensure_kernel_for_venv()
--   local venv_path = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
--   if not venv_path then
--     vim.notify("No virtual environment found.", vim.log.levels.WARN)
--     return
--   end
--
--   -- Canonicalize the venv_path to ensure consistency
--   venv_path = vim.fn.fnamemodify(venv_path, ":p")
--
--   -- Check if the kernel spec already exists
--   local handle = io.popen "jupyter kernelspec list --json"
--   local existing_kernels = {}
--   if handle then
--     local result = handle:read "*a"
--     handle:close()
--     local json = vim.fn.json_decode(result)
--     -- Iterate over available kernel specs to find the one for this virtual environment
--     for kernel_name, data in pairs(json.kernelspecs) do
--       existing_kernels[kernel_name] = true -- Store existing kernel names for validation
--       local kernel_path = vim.fn.fnamemodify(data.spec.argv[1], ":p") -- Canonicalize the kernel path
--       if kernel_path:find(venv_path, 1, true) then
--         vim.notify("Kernel spec for this virtual environment already exists.", vim.log.levels.INFO)
--         return kernel_name
--       end
--     end
--   end
--
--   -- Prompt the user for a custom kernel name, ensuring it is unique
--   local new_kernel_name
--   repeat
--     new_kernel_name = vim.fn.input "Enter a unique name for the new kernel spec: "
--     if new_kernel_name == "" then
--       vim.notify("Please provide a valid kernel name.", vim.log.levels.ERROR)
--       return
--     elseif existing_kernels[new_kernel_name] then
--       vim.notify(
--         "Kernel name '" .. new_kernel_name .. "' already exists. Please choose another name.",
--         vim.log.levels.WARN
--       )
--       new_kernel_name = nil
--     end
--   until new_kernel_name
--
--   -- Create the kernel spec with the unique name
--   print "Creating a new kernel spec for this virtual environment..."
--   local cmd = string.format(
--     '%s -m ipykernel install --user --name="%s"',
--     vim.fn.shellescape(venv_path .. "/bin/python"),
--     new_kernel_name
--   )
--
--   os.execute(cmd)
--   vim.notify("Kernel spec '" .. new_kernel_name .. "' created successfully.", vim.log.levels.INFO)
--   return new_kernel_name
-- end
--
-- -- Automatically start kernel when entering a Quarto buffer
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.qmd", -- Adjust this pattern if necessary for your Quarto files
--   callback = function()
--     if not kernel_initialized then
--       local kernel_name = ensure_kernel_for_venv()
--       if kernel_name then
--         vim.cmd(("MoltenInit %s"):format(kernel_name))
--         kernel_initialized = true -- Set the flag to prevent re-initialization
--       else
--         vim.notify("No kernel to initialize.", vim.log.levels.WARN)
--       end
--     end
--   end,
-- })
--
-- -- Optionally reset the flag when leaving the buffer
-- vim.api.nvim_create_autocmd("BufLeave", {
--   pattern = "*.qmd",
--   callback = function()
--     kernel_initialized = false -- Reset the flag when leaving the buffer
--   end,
-- })

-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
-- -- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "foo script",
--   },
-- }
