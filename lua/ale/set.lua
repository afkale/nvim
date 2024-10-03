vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 1
vim.g.netrw_liststyle = 1
vim.g.netrw_localcopydircmd = "cp -r"

local hide_list = vim.fn["netrw_gitignore#Hide"]() .. [[,\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_hide = 1
vim.g.netrw_list_hide = hide_list

vim.g.c_syntax_for_h = 1

vim.g.maplocalleader = ","

vim.opt.filetype = "plugin"
vim.opt.syntax = "enable"

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

vim.opt.colorcolumn = "100"
vim.opt.showtabline = 2

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "javascript", "json", "typescript", "yaml" },
	command = "setlocal shiftwidth=2 tabstop=2",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua" },
	command = "setlocal shiftwidth=4 tabstop=4",
})
