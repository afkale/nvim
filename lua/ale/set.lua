-- Set the Python 3 host program for Neovim
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- Use C syntax highlighting for .h (header) files
vim.g.c_syntax_for_h = 1

-- Enable filetype detection and syntax highlighting
vim.opt.filetype = "plugin" -- Enable filetype-based settings
vim.opt.syntax = "enable"   -- Enable syntax highlighting

-- Configure grep program to use ripgrep (rg) for searching
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m" -- Format for displaying grep results

-- Configure folding settings
vim.opt.foldmethod = "indent" -- Use indentation levels for folding
vim.opt.foldlevelstart = 99   -- Keep folds open by default

-- Enable line numbers
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Configure text wrapping behavior
vim.opt.wrap = false       -- Disable line wrapping
vim.opt.breakindent = true -- Maintain indentation when wrapping

-- Configure default tab and indentation settings
vim.opt.tabstop = 4       -- Number of spaces per tab
vim.opt.shiftwidth = 4    -- Indentation width
vim.opt.expandtab = false -- Use actual tab characters instead of spaces

-- Disable swap and backup files, enable persistent undo
vim.opt.swapfile = false                                -- Disable swap file creation
vim.opt.backup = false                                  -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir" -- Set undo directory
vim.opt.undofile = true                                 -- Enable persistent undo

-- Configure search behavior
vim.opt.hlsearch = false  -- Disable highlight search
vim.opt.ignorecase = true -- Ignore case in searches
vim.opt.smartcase = true  -- Enable case-sensitive search if uppercase is used
vim.opt.incsearch = true  -- Show search matches while typing

-- Enable terminal colors and cursor highlighting
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.cursorline = true    -- Highlight the current cursor line

-- Scrolling and UI enhancements
vim.opt.scrolloff = 8         -- Keep 8 lines of context above/below cursor
vim.opt.signcolumn = "yes"    -- Always show the sign column
vim.opt.isfname:append("@-@") -- Allow @ in file names

-- Performance tuning
vim.opt.updatetime = 50   -- Reduce the time before the CursorHold event is triggered (default is 4000ms)
vim.opt.timeoutlen = 500  -- Time in milliseconds to wait for a mapped sequence to complete (default is 1000ms)
vim.opt.ttimeoutlen = 10  -- Time in milliseconds to wait for a keycode sequence to complete (useful for escape key responsiveness)
vim.opt.lazyredraw = true -- Improves performance by not redrawing the screen while running macros, registers, etc.
vim.opt.updatetime = 100  -- Adjust update time again (potential duplicate, but 100 is still a reasonable setting)
vim.opt.synmaxcol = 200   -- Limit syntax highlighting to the first 200 columns for performance in very long lines

-- Visual guidelines
vim.opt.colorcolumn = "100" -- Highlight column 88 for better readability
vim.opt.showtabline = 2     -- Always show tab bar

-- Path settings for better file navigation
vim.opt.path:append("**") -- Allow recursive searching of files

-- Ignore unnecessary files in searches
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
