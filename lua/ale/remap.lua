-- Leader
vim.g.mapleader = " "

-- Copy --
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Y", [["+Y]], { noremap = true, silent = true })

-- Sizes --
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", { noremap = true, silent = true })

-- Moves --
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

-- Lines --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Resize --
vim.keymap.set("v", "<S-l>", ">gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", ">>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-h>", "<gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "<<", { noremap = true, silent = true })

-- Splits --
vim.keymap.set("n", "<leader>ss", ":vs<CR><C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sh", ":sp<CR><C-w>j", { noremap = true, silent = true })

-- Terminals --
vim.keymap.set("n", "<leader>ft", ":Floaterminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bt", ":Boterminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pre", ":Precommit<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Tabs --
vim.keymap.set("n", "<leader>tt", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, silent = true })

-- Quifix --
vim.keymap.set("n", "<C-,>", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-.>", ":cprevious<CR>", { noremap = true, silent = true })

-- Leave --
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })

-- Misc --
-- Sort lines command
vim.keymap.set("v", "<C-s>", ":sort<CR>", { noremap = true, silent = true })
-- Open explorer
vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { noremap = true, silent = true })
