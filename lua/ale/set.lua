vim.g.user42 = 'arubio-o'
vim.g.mail42 = 'arubio-o@student.42madrid.com'

vim.g.python3_host_prog = '/usr/bin/python'

vim.g.c_syntax_for_h = 1

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_view_general_options = '--synctex-forward "%s:source:%s#%d" | zathura --fork %s'
vim.g.vimtex_compiler_method = 'latexrun'

vim.g.maplocalleader = ','

vim.opt.filetype = 'plugin'
vim.opt.syntax = 'enable'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
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

vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
