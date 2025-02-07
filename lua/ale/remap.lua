local utils = require("ale.functions.utils")

vim.g.mapleader = " "

vim.keymap.set({ "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_d')

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

-- Tabs --
vim.keymap.set("v", "<S-l>", ">gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-l>", ">>", { noremap = true, silent = true })
vim.keymap.set("v", "<S-h>", "<gv", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "<<", { noremap = true, silent = true })

-- Splits --
vim.keymap.set("n", "<leader>s", ":vs<CR><C-w>l")
vim.keymap.set("n", "<leader>h", ":sp<CR><C-w>j")

-- Buffers --
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", ":bdelete<CR>", { noremap = true, silent = true })

-- Quifix --
vim.keymap.set("n", "<C-,>", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-.>", ":cprevious<CR>", { noremap = true, silent = true })

-- Leave --
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Term --
-- Leave term mode
vim.keymap.set("t", "<C-\\><C-\\>", "<C-\\><C-n>")

-- Misc --
-- Sort lines command
vim.keymap.set("v", "<C-s>", ":sort<CR>", { noremap = true, silent = true })
-- Open explorer
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { noremap = true, silent = true })

function SurroundSelectionWithPair(key)
	local left, right = utils.get_couple(key)
	local c_buf, s_row, s_col, e_row, e_col = utils.get_visual_selection_indices()

	if vim.fn.visualmode() == "v" then
		local text = vim.api.nvim_buf_get_text(c_buf, s_row, s_col, e_row, e_col + 1, {})

		text[1] = left:rep(vim.v.count1) .. text[1]
		text[#text] = text[#text] .. right:rep(vim.v.count1)

		vim.api.nvim_buf_set_text(c_buf, s_row, s_col, e_row, e_col + 1, text)
	else
		for row = s_row, e_row do
			local text = vim.api.nvim_buf_get_text(c_buf, row, s_col, row, e_col + 1, {})

			text[1] = left .. text[1] .. right

			vim.api.nvim_buf_set_text(c_buf, row, s_col, row, e_col + 1, text)
		end
	end
end

for key, _ in pairs(utils.couples) do
	local escaped_key = vim.fn.escape(key, "'")
	local command = string.format(":lua SurroundSelectionWithPair('%s')<CR>", escaped_key)
	vim.keymap.set("v", key, command, { noremap = true, silent = true })
end
