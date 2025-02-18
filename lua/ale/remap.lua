-- Set the leader key to spac
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Copy mappings using system clipboard
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', opts)   -- Copy selection to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts) -- Copy current line or selection
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)          -- Copy entire line

-- Window resizing shortcuts
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", opts) -- Decrease window width

vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", opts) -- Increase window width
vim.keymap.set("n", "<A-j>", ":resize +2<CR>", opts)          -- Increase window height
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", opts)          -- Decrease window height

-- Window navigation mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", opts) -- Move left
vim.keymap.set("n", "<C-l>", "<C-w>l", opts) -- Move right
vim.keymap.set("n", "<C-j>", "<C-w>j", opts) -- Move down
vim.keymap.set("n", "<C-k>", "<C-w>k", opts) -- Move up

-- Terminal window navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", opts)

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Indentation mappings
vim.keymap.set("v", "<S-l>", ">gv", opts)
vim.keymap.set("n", "<S-l>", ">>", opts)
vim.keymap.set("v", "<S-h>", "<gv", opts)
vim.keymap.set("n", "<S-h>", "<<", opts)

-- Split window shortcuts
vim.keymap.set("n", "<leader>ss", ":vs<CR><C-w>l", opts) -- Vertical split
vim.keymap.set("n", "<leader>sh", ":sp<CR><C-w>j", opts) -- Horizontal split

-- Terminal shortcuts
vim.keymap.set({ "t", "n" }, "<C-1>", "<CMD>Boterminal<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-2>", "<CMD>Floaterminal<CR>", opts)
vim.keymap.set("n", "<leader>pre", ":Precommit<CR>", opts)
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", opts)

-- Tab management
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)

-- Quickfix
vim.keymap.set("n", "<C-.>", ":cnext<CR>", opts)
vim.keymap.set("n", "<C-,>", ":cprevious<CR>", opts)
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", opts)
vim.keymap.set("n", "<leader>co", ":botright cwindow<CR>", opts)
vim.keymap.set("n", "<leader>crn",
	":cdo s///c | update<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>")

-- Finding things
vim.keymap.set("n", "<leader>fh", ":help ")
vim.keymap.set("n", "<leader>fg", ":RgSearch<CR>")

-- File explorer
vim.keymap.set("n", "<leader>e", ":lua require'oil'.toggle_float()<CR>", opts)

-- Miscellaneous shortcuts
vim.keymap.set("v", "<C-s>", ":sort<CR>", opts) -- Sort lines visual
