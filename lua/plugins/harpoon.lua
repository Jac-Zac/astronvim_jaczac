-- Setting up Harpoon
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "AstroNvim/astroui", opts = { icons = { Harpoon = "󱡀" } } },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        -- local term_string = vim.fn.exists "$TMUX" == 1 and "tmux" or "term"
        --
        local prefix = "<Leader>h"
        maps.n[prefix] = { desc = require("astroui").get_icon("Harpoon", 1, true) .. "Harpoon" }

        maps.n[prefix .. "a"] = { function() require("harpoon"):list():add() end, desc = "Add file" }
        maps.n[prefix .. "m"] = {
          function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
          desc = "Toggle quick menu",
        }
        -- Other possible configs
        -- maps.n["<C-x>"] = {
        --   function()
        --     vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
        --       local num = tonumber(input)
        --       if num then require("harpoon"):list():select(num) end
        --     end)
        --   end,
        --   desc = "Goto index of mark",
        -- }
        maps.n[prefix .. "p"] = { function() require("harpoon"):list():prev() end, desc = "Goto previous mark" }
        maps.n[prefix .. "n"] = { function() require("harpoon"):list():next() end, desc = "Goto next mark" }
        -- maps.n[prefix .. "t"] = { "<Cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" }
      end,
    },
  },
}
