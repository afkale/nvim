-- Shared keymap helper (definitions live in lua/ale/keys.lua to avoid
-- redefining map()/kmap() in every file)
local map = require("ale.keys").map

-- Copy mappings using system clipboard
map({ "n", "v", "x" }, "<leader>y", [["+y]], "Copy selection or line to system clipboard")
map("n", "<leader>Y", [["+Y]], "Copy entire line to system clipboard")
map({ "n", "v", "x" }, "<leader>p", [["+p]], "Paste from system clipboard")

-- Better J behavior
map("n", "J", "mzJ`z", "Join lines and keep cursor position")

-- Move lines up/down
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Better indenting in visual mode (reselect after indent)
map("v", "<", "<gv", "Indent left and reselect")
map("v", ">", ">gv", "Indent right and reselect")

-- Window resizing shortcuts
map("n", "<A-h>", ":vertical resize -2<CR>", "Decrease window width")
map("n", "<A-l>", ":vertical resize +2<CR>", "Increase window width")
map("n", "<A-j>", ":resize +2<CR>", "Increase window height")
map("n", "<A-k>", ":resize -2<CR>", "Decrease window height")

-- Equalize window sizes
map("n", "<leader>w=", "<C-w>=", "Equalize window sizes")

-- Window navigation mappings
map("n", "<C-h>", "<C-w>h", "Jump to left window")
map("n", "<C-l>", "<C-w>l", "Jump to right window")
map("n", "<C-j>", "<C-w>j", "Jump to window below")
map("n", "<C-k>", "<C-w>k", "Jump to window above")

-- Exit terminal mode
map("t", "<C-\\><C-\\>", "<C-\\><C-n>", "Exit terminal mode")
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode (double escape)")

-- Quickfix
map("n", "<C-n>", ":cnext<CR>", "Go to next quickfix item")
map("n", "<C-p>", ":cprev<CR>", "Go to previous quickfix item")

-- Better quickfix navigation with leader
map("n", "<leader>cn", ":cnext<CR>", "Next quickfix item")
map("n", "<leader>cp", ":cprev<CR>", "Previous quickfix item")
map("n", "<leader>co", ":copen<CR>", "Open quickfix window")
map("n", "<leader>cq", ":cclose<CR>", "Close quickfix window")

-- Miscellaneous shortcuts
map("v", "<C-s>", ":sort<CR>", "Sort selected lines")
map("n", "<leader>zz", "<C-W>|", "Zoom current window")

-- Clear search highlight with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", "Clear search highlight")

-- Better 'n' and 'N' behavior (center on screen)
map("n", "n", "nzzzv", "Next search result (centered)")
map("n", "N", "Nzzzv", "Previous search result (centered)")

-- Quick save
map("n", "<leader>w", ":w<CR>", "Save file")
map("n", "<leader>q", ":q<CR>", "Close window")
map("n", "<leader>Q", ":qa<CR>", "Quit all")
