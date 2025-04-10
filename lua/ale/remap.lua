-- Set the leader key to spac
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
local set = vim.keymap.set

-- Copy mappings using system clipboard
set({ "v", "x" }, "<leader>y", '"+y', opts)   -- Copy selection to system clipboard
set({ "n", "v" }, "<leader>y", [["+y]], opts) -- Copy current line or selection
set("n", "<leader>Y", [["+Y]], opts)          -- Copy entire line

-- Window resizing shortcuts
set("n", "<A-h>", ":vertical resize -2<CR>", opts) -- Decrease window width

set("n", "<A-l>", ":vertical resize +2<CR>", opts) -- Increase window width
set("n", "<A-j>", ":resize +2<CR>", opts)          -- Increase window height
set("n", "<A-k>", ":resize -2<CR>", opts)          -- Decrease window height

-- Window navigation mappings
set("n", "<C-h>", "<C-w>h", opts) -- Move left
set("n", "<C-l>", "<C-w>l", opts) -- Move right
set("n", "<C-j>", "<C-w>j", opts) -- Move down
set("n", "<C-k>", "<C-w>k", opts) -- Move up

-- Terminal window navigation
set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", opts)
set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", opts)
set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", opts)
set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", opts)

-- Terminal shortcuts
set("t", "<C-\\><C-\\>", "<C-\\><C-n>", opts)

-- Tab management
set("n", "<leader>tn", ":tabnew<CR>", opts)
set("n", "<leader>tc", ":tabclose<CR>", opts)

-- Quickfix
set("n", "<C-.>", ":cnext<CR>", opts)
set("n", "<C-,>", ":cprevious<CR>", opts)
set("n", "<leader>cc", ":cclose<CR>", opts)
set("n", "<leader>co", ":copen<CR>", opts)
set("n", "<leader>crn", ":execute 'cdo s/' . input('Find: ') . '/' . input('Replace: ') . '/gc | update'<CR>")

-- Miscellaneous shortcuts
set("v", "<C-s>", ":sort<CR>", opts) -- Sort lines visual

-- Command remaps
set('c', '<C-p>', '<Up>', opts)
set('c', '<C-n>', '<Down>', opts)
