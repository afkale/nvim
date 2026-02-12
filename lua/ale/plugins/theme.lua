return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = { transparency = true}
      })

      vim.cmd("colorscheme rose-pine")
    end
  },
  {
    'maxmx03/roseline',
    opts = {},
    dependencies = {
      'rose-pine/neovim',
    }
  }
}
