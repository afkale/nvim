-- utils.kmset the leader key to spac
vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Copy mappings using system clipboard
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', opts)   -- Copy selection to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts) -- Copy current line or selection
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)          -- Copy entire line

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Move lines up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

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

vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", opts)

-- Quickfix
vim.keymap.set("n", "<leader>cc", ":copen<CR>")
vim.keymap.set("n", "<C-n>", ":cnext<CR>")
vim.keymap.set("n", "<C-p>", ":cprev<CR>")

-- Miscellaneous shortcuts
vim.keymap.set("v", "<C-s>", ":sort<CR>", opts) -- Sort lines visual
