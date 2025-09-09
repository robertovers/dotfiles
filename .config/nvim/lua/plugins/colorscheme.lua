return {
  "tjdevries/colorbuddy.nvim",
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      local colours_name = "mycolours"
      vim.g.colors_name = colours_name

      local lush = require("lush")
      local util = require("zenbones.util")
      local hsluv = lush.hsluv

      local bg = vim.o.background

      local palette = util.palette_extend({
        bg = hsluv("#101010"),
        fg = hsluv("#d9d9d9").li(10),
        grey = hsluv("#919191"),
        rose = hsluv("#e17899").li(10),
        leaf = hsluv("#719872").li(10),
        wood = hsluv("#ffde99"),
        water = hsluv("#98bede"),
        blossom = hsluv("#999abd"),
        sky = hsluv("#84acac").li(10),
        orange = hsluv("#e19972"),
      }, bg)

      local generator = require("zenbones.specs")
      local base_specs = generator.generate(palette, bg, generator.get_global_config(colours_name, bg))

      local specs = lush.extends({ base_specs }).with(function()
        ---@diagnostic disable: undefined-global
        return {
          Comment { base_specs.Comment, fg = palette.grey, gui = "nil" },
          Constant { base_specs.Constant, fg = palette.leaf, gui = "nil" },
          String { base_specs.String, fg = palette.leaf, gui = "nil"},
          Type { base_specs.Type, fg = palette.grey, gui = "nil"},
          Statement { base_specs.Statement, fg = palette.blossom, gui = "nil" },
          Keyword { fg = palette.rose.de(12), gui = "nil" },
          Exception { Keyword, gui = "nil" },
          PreProc { fg = palette.rose.de(25), gui = "nil" },
          Identifier { fg = palette.fg, gui = "nil" },
          Function { fg = palette.sky, gui = "nil" },
          Special { fg = palette.blossom.li(26), gui = "nil" },
          Number { base_specs.Number, fg = palette.wood.de(30), gui = "nil" },
          CursorLine { bg = palette.bg.li(20) },
          NvimTreeCursorLine { bg = palette.bg.li(20) },
          NvimTreeNormal { bg = palette.bg },
          NvimTreeIndentMarker { bg = palette.bg },
        }
      end)

      lush(specs)
      require("zenbones.term").apply_colors(palette)
    end,
  },
}
