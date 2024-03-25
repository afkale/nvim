vim.g.mapleader = ' '

vim.keymap.set({ 'v', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'X', '"_d')

vim.keymap.set('n', '<leader><leader>', ':source<cr>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', 'tw', vim.cmd.tabnew)
vim.keymap.set('n', 'tn', vim.cmd.tabnext)
vim.keymap.set('n', 'tp', vim.cmd.tabprev)
vim.keymap.set('n', 'tc', vim.cmd.tabclose)

vim.keymap.set('n', 'sv', vim.cmd.vsplit)
vim.keymap.set('n', 'sh', vim.cmd.split)
vim.keymap.set('n', 'sc', vim.cmd.close)

vim.keymap.set('n', 'mp', vim.cmd.bp)
vim.keymap.set('n', 'mn', vim.cmd.bn)
vim.keymap.set('n', 'mc', vim.cmd.bd)
vim.keymap.set('n', 'mf', vim.lsp.buf.format)

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')

vim.keymap.set('n', 'zz', '<cmd>write<cr>')
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

vim.keymap.set('n', '<leader><leader>', function() vim.cmd('so') end)

vim.cmd("autocmd BufEnter * :lua require('lazygit.utils').project_root_dir()")
