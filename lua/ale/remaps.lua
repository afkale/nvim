-- utils.kmset the leader key to spac
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

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Move lines up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Terminal window navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", opts)

-- Terminal shortcuts
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", opts)

-- Tab management
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)

-- Quickfix
vim.keymap.set("n", "<C-.>", ":cnext<CR>", opts)
vim.keymap.set("n", "<C-,>", ":cprevious<CR>", opts)
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", opts)
vim.keymap.set("n", "<leader>co", ":copen<CR>", opts)
vim.keymap.set("n", "<leader>crn", ":execute 'cdo s/' . input('Find: ') . '/' . input('Replace: ') . '/gc | update'<CR>")

-- Miscellaneous shortcuts
vim.keymap.set("v", "<C-s>", ":sort<CR>", opts) -- Sort lines visual

-- Command remaps
vim.keymap.set('c', '<C-p>', '<Up>', opts)
vim.keymap.set('c', '<C-n>', '<Down>', opts)
