-- Set the Python 3 host program for Neovim
vim.g.python3_host_prog = "/usr/bin/python3"

vim.g.autoformat = true

local opt = vim.opt

-- Enable filetype detection and syntax highlighting
opt.filetype = "plugin" -- Enable filetype-based settings
opt.syntax = "enable"   -- Enable syntax highlighting

-- Configure grep program to use ripgrep (rg) for searching
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m" -- Format for displaying grep results

-- Configure folding settings
opt.foldmethod = "indent" -- Use indentation levels for folding
opt.foldlevelstart = 99   -- Keep folds open by default

-- Enable line numbers
opt.number = true         -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers

-- Configure text wrapping behavior
opt.wrap = false       -- Disable line wrapping
opt.breakindent = true -- Maintain indentation when wrapping

-- Configure default tab and indentation settings
opt.tabstop = 2       -- Number of spaces per tab
opt.shiftwidth = 2    -- Indentation width
opt.expandtab = false -- Use actual tab characters instead of spaces

-- Disable swap and backup files, enable persistent undo
opt.swapfile = false                                -- Disable swap file creation
opt.backup = false                                  -- Disable backup files
opt.undodir = os.getenv("HOME") .. "/.nvim/undodir" -- Set undo directory
opt.undofile = true                                 -- Enable persistent undo

-- Configure search behavior
opt.hlsearch = false  -- Disable highlight search
opt.ignorecase = true -- Ignore case in searches
opt.smartcase = true  -- Enable case-sensitive search if uppercase is used
opt.incsearch = true  -- Show search matches while typing

-- Enable terminal colors and cursor highlighting
opt.termguicolors = true -- Enable 24-bit colors
opt.cursorline = true    -- Highlight the current cursor line

-- Scrolling and UI enhancements
opt.scrolloff = 8         -- Keep 8 lines of context above/below cursor
opt.signcolumn = "yes"    -- Always show the sign column
opt.isfname:append("@-@") -- Allow @ in file names

-- Visual guidelines
opt.colorcolumn = "100" -- Highlight column 88 for better readability

-- Path settings for better file navigation
opt.path:append("**") -- Allow recursive searching of files

-- Ignore unnecessary files in searches
opt.wildignore = {
	-- General version control and cache directories
	"**/.git/**",
	"**/.svn/**",
	"**/.hg/**",
	"**/__pycache__/**",
	"**/.DS_Store",
	"**/Thumbs.db",

	-- Dependency folders
	"**/node_modules/**",
	"**/.venv/**",
	"**/env/**",
	"**/vendor/**",
	"**/build/**",
	"**/dist/**",
	"**/target/**",
	"**/.next/**",
	"**/.yarn/**",

	-- Temporary and backup files
	"*.swp",
	"*.swo",
	"*.bak",
	"*.tmp",
	"*.lock",
	"*.log",

	-- Compiled and bytecode files
	"*.class",
	"*.pyc",
	"*.pyo",
	"*.exe",
	"*.dll",
	"*.o",
	"*.obj",

	-- IDE and Editor-specific files
	"**/.idea/**",
	"**/.vscode/**",

	-- Tags and ctags files
	"tags",
	"*.tags",
	"*.ctags",
}
