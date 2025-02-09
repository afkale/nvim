vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

vim.g.c_syntax_for_h = 1

vim.opt.filetype = "plugin"
vim.opt.syntax = "enable"

vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "88"
vim.opt.showtabline = 2

vim.opt.path:append("**")
vim.opt.wildignore = {
	"**/__pycache__/**",
	"**/.venv/**",
	"**/node_modules/**",
	"**/.git/**",
	"**/.svn/**",
	"**/.hg/**",
	"**/build/**",
	"**/target/**",
	"*.bak",
	"*.pyc",
	"*.class",
	"tags",
}
