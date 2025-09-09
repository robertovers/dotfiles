return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
  keys = {
    { 
      "<leader>g", 
      function() 
        require("nvim-tree.api").tree.toggle() 
      end, 
      desc = "Toggle NvimTree" 
    },
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end,
}
