local u = require("ale.extra.utils")

-- utils.kmset the leader key to spac
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Copy mappings using system clipboard
u.kmset({ "v", "x" }, "<leader>y", '"+y', opts)   -- Copy selection to system clipboard
u.kmset({ "n", "v" }, "<leader>y", [["+y]], opts) -- Copy current line or selection
u.kmset("n", "<leader>Y", [["+Y]], opts)          -- Copy entire line

-- Window resizing shortcuts
u.kmset("n", "<A-h>", ":vertical resize -2<CR>", opts) -- Decrease window width

u.kmset("n", "<A-l>", ":vertical resize +2<CR>", opts) -- Increase window width
u.kmset("n", "<A-j>", ":resize +2<CR>", opts)          -- Increase window height
u.kmset("n", "<A-k>", ":resize -2<CR>", opts)          -- Decrease window height

-- Window navigation mappings
u.kmset("n", "<C-h>", "<C-w>h", opts) -- Move left
u.kmset("n", "<C-l>", "<C-w>l", opts) -- Move right
u.kmset("n", "<C-j>", "<C-w>j", opts) -- Move down
u.kmset("n", "<C-k>", "<C-w>k", opts) -- Move up

-- Terminal window navigation
u.kmset("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", opts)
u.kmset("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", opts)
u.kmset("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", opts)
u.kmset("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", opts)

-- Terminal shortcuts
u.kmset("t", "<C-\\><C-\\>", "<C-\\><C-n>", opts)

-- Tab management
u.kmset("n", "<leader>tn", ":tabnew<CR>", opts)
u.kmset("n", "<leader>tc", ":tabclose<CR>", opts)

-- Quickfix
u.kmset("n", "<C-.>", ":cnext<CR>", opts)
u.kmset("n", "<C-,>", ":cprevious<CR>", opts)
u.kmset("n", "<leader>cc", ":cclose<CR>", opts)
u.kmset("n", "<leader>co", ":copen<CR>", opts)
u.kmset("n", "<leader>crn", ":execute 'cdo s/' . input('Find: ') . '/' . input('Replace: ') . '/gc | update'<CR>")

-- Miscellaneous shortcuts
u.kmset("v", "<C-s>", ":sort<CR>", opts) -- Sort lines visual
u.kmset("n", "<C-s>", u.switch, opts)    -- Switch character pairs

-- Command remaps
u.kmset('c', '<C-p>', '<Up>', opts)
u.kmset('c', '<C-n>', '<Down>', opts)
