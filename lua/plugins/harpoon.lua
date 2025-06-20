return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", optional = true },
    { "AstroNvim/astroui", opts = { icons = { Harpoon = "󱡀" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>h"
        maps.n[prefix] = { desc = require("astroui").get_icon("Harpoon", 1, true) .. "Harpoon" }

        maps.n[prefix .. "a"] = { function() require("harpoon"):list():add() end, desc = "Add file" }
        maps.n[prefix .. "e"] = {
          function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
          desc = "Toggle quick menu",
        }
        -- maps.n["<C-x>"] = {
        --   function()
        --     vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
        --       local num = tonumber(input)
        --       if num then require("harpoon"):list():select(num) end
        --     end)
        --   end,
        --   desc = "Goto index of mark",
        -- }
        --

        for i = 1, 5 do
          maps.n[prefix .. i] = {
            function() require("harpoon"):list():select(i) end,
            desc = "Goto mark " .. i,
          }
        end
        -- maps.n["<C-p>"] = { function() require("harpoon"):list():prev() end, desc = "Goto previous mark" }
        -- maps.n["<C-n>"] = { function() require("harpoon"):list():next() end, desc = "Goto next mark" }
      end,
    },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { harpoon = true } },
    },
  },
}
