return {
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local kmopts = { noremap = true, silent = true }

      vim.keymap.set('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>', kmopts)
      vim.keymap.set('n', '<leader>mm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', kmopts)
      vim.keymap.set('n', '<leader>mp', ':lua require("harpoon.ui").nav_prev()<CR>', kmopts)
      vim.keymap.set('n', '<leader>mn', ':lua require("harpoon.ui").nav_next()<CR>', kmopts)
      vim.keymap.set('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', kmopts)
      vim.keymap.set('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', kmopts)
      vim.keymap.set('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', kmopts)
      vim.keymap.set('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', kmopts)
      vim.keymap.set('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<CR>', kmopts)
      vim.keymap.set('n', '<leader>6', ':lua require("harpoon.ui").nav_file(6)<CR>', kmopts)
      vim.keymap.set('n', '<leader>7', ':lua require("harpoon.ui").nav_file(7)<CR>', kmopts)
      vim.keymap.set('n', '<leader>8', ':lua require("harpoon.ui").nav_file(8)<CR>', kmopts)
      vim.keymap.set('n', '<leader>9', ':lua require("harpoon.ui").nav_file(9)<CR>', kmopts)
    end
  },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      local kmopts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader><space>", ":GFiles<CR>", kmopts)
      vim.keymap.set("n", "<leader>ff", ":Files<CR>", kmopts)
      vim.keymap.set("n", "<leader>fg", ":RG<CR>", kmopts)
      vim.keymap.set("n", "<leader>fh", ":Helptags<CR>", kmopts)
    end

  },
}
