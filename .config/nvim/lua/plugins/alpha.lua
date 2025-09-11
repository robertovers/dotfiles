return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  keys = {
    { "<leader>h", ":Alpha<CR>", desc = "Alpha Dashboard" },
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                        ]],
      [[         (:)_                           ]],
      [[       ,'    `.                         ]],
      [[      :        :                        ]],
      [[      |        |              ___       ]],
      [[      |       /|    ______   // _\      ]],
      [[      ; \  _,' :  ,'      `. \\  -\     ]],
      [[     /          \/          \ \\  :     ]],
      [[    (            :  ------.  `-'  |     ]],
      [[ ____\___    ____|______   \______|____ ]],
      [[         |::|           '--`            ]],
      [[         |::|                           ]],
      [[         |::|                           ]],
      [[         |::|                           ]],
      [[         |::;                           ]],
      [[         `:/                            ]]
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("c", "config", ":e ~/.config/nvim/init.lua<CR>"),
      dashboard.button("q", "quit neovim", ":qa<CR>"),
    }

    local function footer()
      local str = "[._.]"
      return str
    end

    dashboard.section.footer.val = footer()

    dashboard.section.header.opts.hl = "PreProc"
    dashboard.section.footer.opts.hl = "Type"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
