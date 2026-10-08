-- Shared keymap helper (definitions live in lua/ale/keys.lua to avoid
-- redefining map()/kmap() in every file)
local map = require("ale.keys").map

-- Copy mappings using system clipboard
map({ "n", "v", "x" }, "<leader>y", [["+y]], "Copy selection or line to system clipboard")
map("n", "<leader>Y", [["+Y]], "Copy entire line to system clipboard")

-- Better J behavior
map("n", "J", "mzJ`z", "Join lines and keep cursor position")

-- Move lines up/down
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Better indenting in visual mode
map("v", "<", "<gv", "Indent left and reselect")
map("v", ">", ">gv", "Indent right and reselect")

-- Window resizing shortcuts
map("n", "<A-h>", ":vertical resize -2<CR>", "Decrease window width")
map("n", "<A-l>", ":vertical resize +2<CR>", "Increase window width")
map("n", "<A-j>", ":resize +2<CR>", "Increase window height")
map("n", "<A-k>", ":resize -2<CR>", "Decrease window height")

-- Window navigation mappings
map("n", "<C-h>", "<C-w>h", "Jump to left window")
map("n", "<C-l>", "<C-w>l", "Jump to right window")
map("n", "<C-j>", "<C-w>j", "Jump to window below")
map("n", "<C-k>", "<C-w>k", "Jump to window above")

-- Exit terminal mode
map("t", "<C-\\><C-\\>", "<C-\\><C-n>", "Exit terminal mode")

-- Quickfix
map("n", "<C-n>", ":cnext<CR>", "Go to next quickfix item")
map("n", "<C-p>", ":cprev<CR>", "Go to previous quickfix item")

-- Miscellaneous shortcuts
map("v", "<C-s>", ":sort<CR>", "Sort selected lines")
map(
  "n",
  "<leader>tt",
  ":vsplit | term tmux -u new-session -s 'nvim_" .. vim.fn.getpid() .. "' -n 'nvim_" .. vim.fn.getpid() .. "'<CR>i",
  "Open tmux session in a vertical split terminal"
)
map("n", "<leader>zz", "<C-W>|", "Zoom current window")