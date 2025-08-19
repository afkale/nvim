return {
  {
    'afkale/wswitcher.nvim',
    config = function()
      require('wswitcher').setup()
    end
  },
  {
    'afkale/terminale.nvim',
    config = function()
      local terminale = require 'terminale'

      terminale.setup({
        lazygit = {
          hidden = true,
          window_theme = 'default',
          command = 'lazygit --use-config-dir ' .. vim.fn.stdpath('config') .. '/lazygit',
          user_command = 'Lazygit',
          on_enter = function() vim.cmd('startinsert') end,
          keymap = {
            {
              cmd = '<leader>gg',
              mode = { 'n', 't' },
              key = '<CMD>Lazygit<CR>',
            },
          },
        },
        btop = {
          hidden = true,
          window_theme = 'default',
          command = 'btop',
          user_command = 'Btop',
          on_enter = function() vim.cmd('startinsert') end,
          keymap = {
            {
              cmd = '<A-b>',
              mode = { 'n', 't' },
              key = '<CMD>Btop<CR>',
            },
          },
        },
      })
    end
  }
}
