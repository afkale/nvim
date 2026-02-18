-- Set the Python 3 host program for Neovim
vim.g.python3_host_prog = '/usr/bin/python3'

vim.g.autoformat = true

-- Basic settings
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.scrolloff = 10        -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- Enable filetype detection and syntax highlighting
vim.opt.filetype = 'plugin' -- Enable filetype-based settings
vim.opt.syntax = 'enable'   -- Enable syntax highlighting

-- Configure grep program to use ripgrep (rg) for searching
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m' -- Format for displaying grep results

-- Visual guidelines
vim.opt.colorcolumn = "100"     -- Highlight column 88 for better readability
vim.opt.virtualedit = 'onemore' -- Copy indent from current line

-- Indentation
vim.opt.tabstop = 2        -- Tab width
vim.opt.shiftwidth = 2     -- Indent width
vim.opt.softtabstop = 2    -- Soft tab stop
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch = false  -- Don't highlight search results
vim.opt.incsearch = true  -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = 'yes'   -- Always show sign column
vim.opt.colorcolumn = '100'  -- Show column at 100 characters
vim.opt.showmatch = true     -- Highlight matching brackets
vim.opt.matchtime = 2        -- How long to show matching bracket
vim.opt.cmdheight = 1        -- Command line height
vim.opt.completeopt = 'menuone,popup,noinsert'
vim.opt.showmode = false     -- Don't show mode in command line
vim.opt.pumheight = 10       -- Popup menu height
vim.opt.conceallevel = 0     -- Don't hide markup
vim.opt.concealcursor = ''   -- Don't hide cursor line markup
vim.opt.lazyredraw = true    -- Don't redraw during macros
vim.opt.synmaxcol = 300      -- Syntax highlighting limit

-- File handling
vim.opt.backup = false                            -- Don't create backup files
vim.opt.writebackup = false                       -- Don't create backup before writing
vim.opt.swapfile = false                          -- Don't create swap files
vim.opt.undofile = true                           -- Persistent undo
vim.opt.undodir = vim.fn.expand('~/.vim/undodir') -- Undo directory
vim.opt.updatetime = 300                          -- Faster completion
vim.opt.timeoutlen = 500                          -- Key timeout duration
vim.opt.ttimeoutlen = 0                           -- Key code timeout
vim.opt.autoread = true                           -- Auto reload files changed outside vim
vim.opt.autowrite = false                         -- Don't auto save

-- Behavior settings
vim.opt.hidden = true                  -- Allow hidden buffers
vim.opt.errorbells = false             -- No error bells
vim.opt.backspace = 'indent,eol,start' -- Better backspace behavior
vim.opt.autochdir = false              -- Don't auto change directory
vim.opt.iskeyword:append('-')          -- Treat dash as part of word
vim.opt.path:append('**')              -- include subdirectories in search
vim.opt.mouse = 'a'                    -- Enable mouse support
vim.opt.modifiable = true              -- Allow buffer modifications
vim.opt.encoding = 'UTF-8'             -- Set encoding

-- Folding settings
vim.opt.foldmethod = 'expr' -- Use expression for folding
vim.opt.foldlevel = 99      -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Key mappings
vim.g.mapleader = ' ' -- Set leader key to space
vim.g.maplocalleader = ' '


-- Remove border configuration entirely
vim.g.fzf_layout = {
  window = {
    border = "sharp",
    width = 0.9,
    height = 0.9,
  }
}

vim.g.fzf_vim = vim.g.fzf_vim or {}
vim.g.fzf_vim.preview_window = { "down,60%,hidden", "ctrl-/" }
