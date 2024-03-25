vim.g.user42 = 'arubio-o'
vim.g.mail42 = 'arubio-o@student.42madrid.com'

vim.g.python3_host_prog = '/usr/bin/python'

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_view_general_options = '--synctex-forward "%s:source:%s#%d" | zathura --fork %s'
vim.g.vimtex_compiler_method = 'latexrun'

vim.g.maplocalleader = ','

vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.9
vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
vim.g.lazygit_floating_window_use_plenary = 0
vim.g.lazygit_use_neovim_remote = 0

vim.g.lazygit_use_custom_config_file_path = 1
vim.g.lazygit_config_file_path = os.getenv('HOME') .. '/.config/lazygit/config.yml'

vim.opt.filetype = 'plugin'
vim.opt.syntax = 'enable'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.nvim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'
vim.opt.showtabline = 2
