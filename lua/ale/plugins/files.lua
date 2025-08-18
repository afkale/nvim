return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "echasnovski/mini.files",
    config = function()
      require("mini.files").setup()
    end
  },
  {
    "echasnovski/mini.pick",
    config = function()
      require("mini.pick").setup()
    end
  },
}
