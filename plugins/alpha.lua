return {
  "goolord/alpha-nvim",
  cmd = "Alpha",
  opts = function()
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = {
      "            *            *     ,MMM8&&&.            *          .        ",
      "       .                      MMMM88&&&&&,    .                         ",
      "                 *           MMM88&&&&&&&&                *      .      ",
      "                             MMM88&&&&&&&&          .                 . ",
      "        .             .      'MMM88&&&&&&'                   .          ",
      "                               'MMM8&&&'          *                     ",
      "            .                .                          .         *     ",
      "   .               *                         *                          ",
      "                                 .                       *      .       ",
      "         *            /^--^\\     /^--^\\     /^--^\\                .   ",
      "                .     \\____/     \\____/     \\____/       .           ",
      "    .                /      \\   /      \\   /      \\                  ",
      "           .        |        | |        | |        |           .        ",
      "                     \\__  __/   \\__  __/   \\__  __/                  ",
      "|^|^|^|^|^|^|^|^|^|^|^|^\\ \\^|^|^|^/ /^|^|^|^|^\\ \\^|^|^|^|^|^|^|^|^|^|^|^|",
      "| | | | | | | | | | | | |\\ \\| | |/ /| | | | | |\\ \\| | | | | | | | | | | |",
      "#########################/ /#####\\ \\###########/ /#######################",
      "| | | | | | | | | | | | |\\/| | | |\\/| | | | | |\\/ | | | | | | | | | | | |",
      "|_|_|_|_|_|_|_|_|_|  Jac Zac Custom Astro_Nvim config |_|_|_|_|_|_|_|_|_|",
    }
    dashboard.section.header.opts.hl = "DashboardHeader"
    dashboard.section.footer.opts.hl = "DashboardFooter"

    local button, get_icon = require("astronvim.utils").alpha_button, require("astronvim.utils").get_icon
    dashboard.section.buttons.val = {
      button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
      button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
      button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
      button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
      button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
      button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
    }

    dashboard.config.layout = {
      { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
      dashboard.section.header,
      { type = "padding", val = 5 },
      dashboard.section.buttons,
      { type = "padding", val = 3 },
      dashboard.section.footer,
    }
    dashboard.config.opts.noautocmd = true
    return dashboard
  end,
  config = require "plugins.configs.alpha",
}
