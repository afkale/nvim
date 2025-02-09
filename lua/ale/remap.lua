-- Leader
vim.g.mapleader = " "

-- Copy --
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Y", [["+Y]], { noremap = true, silent = true })

-- Sizes --
vim.keymap.set("n", "<A-h>", "<CMD>vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", "<CMD>vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", "<CMD>resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", "<CMD>resize -2<CR>", { noremap = true, silent = true })

-- Moves --
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { noremap = true, silent = true })

-- Lines --
vim.keymap.set("v", "J", "<CMD>m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", "<CMD>m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Resize --
vim.keymap.set("v", "<S-l>", ">gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", ">>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-h>", "<gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "<<", { noremap = true, silent = true })

-- Splits --
vim.keymap.set("n", "<leader>ss", "<CMD>vs<CR><C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>sh", "<CMD>sp<CR><C-w>j", { noremap = true, silent = true })

-- Terminals --
vim.keymap.set("n", "<leader>ft", "<CMD>Floaterminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", "<CMD>Boterminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pre", "<CMD>Precommit<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Tabs --
vim.keymap.set("n", "<leader>tn", "<CMD>tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tc", "<CMD>tabclose<CR>", { noremap = true, silent = true })

-- Quifix --
vim.keymap.set("n", "<C-,>", "<CMD>cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-.>", "<CMD>cprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cc", "<CMD>cclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>co", "<CMD>copen<CR>", { noremap = true, silent = true })

-- Leave --
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })

-- Find --
vim.keymap.set("n", "<leader>ff", ":find ")
vim.keymap.set("n", "<leader>fh", ":help ")
vim.keymap.set("n", "<leader>fg", "<CMD>RgSearch<CR>")

-- Explorer
vim.keymap.set("n", "<leader>e", "<CMD>Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>E", "<CMD>FilesHere<CR>", { noremap = true, silent = true })

-- Misc --
-- Sort lines
vim.keymap.set("v", "<C-s>", "<CMD>sort<CR>", { noremap = true, silent = true })
-- Source file
vim.keymap.set("n", "<leader><leader>", "<CMD>source<CR>", { noremap = true, silent = true })
-- Open diagnostic
vim.keymap.set("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
