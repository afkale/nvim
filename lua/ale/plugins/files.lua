return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'echasnovski/mini.files',
    config = function()
      require('mini.files').setup({ mappings = { close = '<ESC>' } })
    end
  },
  {
    'echasnovski/mini.pick',
    config = function()
      require('mini.pick').setup()
    end
  },
}
