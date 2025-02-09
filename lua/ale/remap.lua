-- Set the leader key to space
vim.g.mapleader = " "

-- Copy mappings using system clipboard
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y', { noremap = true, silent = true })   -- Copy selection to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true }) -- Copy current line or selection
vim.keymap.set("n", "<leader>Y", [["+Y]], { noremap = true, silent = true })          -- Copy entire line

-- Window resizing shortcuts
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true }) -- Decrease window width
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true }) -- Increase window width
vim.keymap.set("n", "<A-j>", ":resize +2<CR>", { noremap = true, silent = true })          -- Increase window height
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", { noremap = true, silent = true })          -- Decrease window height

-- Window navigation mappings
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- Move left
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- Move right
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- Move down
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- Move up

-- Terminal window navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { noremap = true, silent = true })

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Indentation mappings
vim.keymap.set("v", "<S-l>", ">gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", ">>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-h>", "<gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "<<", { noremap = true, silent = true })

-- Split window shortcuts
vim.keymap.set("n", "<leader>ss", ":vs<CR><C-w>l", { noremap = true, silent = true }) -- Vertical split
vim.keymap.set("n", "<leader>sh", ":sp<CR><C-w>j", { noremap = true, silent = true }) -- Horizontal split

-- Terminal shortcuts
vim.keymap.set("n", "<leader>ft", ":Floaterminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", "<CMD>Boterminal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pre", ":Precommit<CR>", { noremap = true, silent = true })

-- Tab management
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true })

-- Quickfix navigation
vim.keymap.set("n", "<C-.>", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-,>", ":cprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>co", ":copen<CR>", { noremap = true, silent = true })


-- File finding and searching
vim.keymap.set("n", "<leader>ff", ":find ")
vim.keymap.set("n", "<leader>fh", ":help ")
vim.keymap.set("n", "<leader>fg", ":RgSearch<CR>")

-- File explorer
vim.keymap.set("n", "<leader>e", ":Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>E", ":FilesHere<CR>", { noremap = true, silent = true })

-- Miscellaneous shortcuts
vim.keymap.set("v", "<C-s>", ":sort<CR>", { noremap = true, silent = true })                         -- Sort lines visual
vim.keymap.set("n", "<leader><leader>", ":source<CR>", { noremap = true, silent = true })            -- Source File
vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true }) -- Open diagnostic float
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })                             -- Exit insert mode
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })                                 -- Disable Ex mode
