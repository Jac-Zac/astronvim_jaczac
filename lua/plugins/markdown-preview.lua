---@type LazySpec
return {
  "iamcco/markdown-preview.nvim",
  -- Install the Node server without modifying the plugin's tracked lockfile.
  build = "cd app && yarn install --frozen-lockfile --non-interactive",
}
