return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-mini/mini.files',
    config = function()
      require('mini.files').setup({ mappings = { close = '<ESC>' } })
    end
  },
  {
    'nvim-mini/mini.icons',
    config = function()
      require('mini.icons').setup()
    end
  },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }
  },
}
