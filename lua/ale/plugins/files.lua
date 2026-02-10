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
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }
  },
}
