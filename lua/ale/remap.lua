local utils = require("ale.functions.utils")

-- JOBIDS
local term_job_id = 0

-- Leader
vim.g.mapleader = " "

-- Copy --
vim.keymap.set({ "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

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
vim.keymap.set("n", "<leader>ss", ":vs<CR><C-w>l")
vim.keymap.set("n", "<leader>sh", ":sp<CR><C-w>j")
vim.keymap.set("n", "<leader>sf",
	function()
		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.8)
		local row = math.floor((vim.o.lines - height) / 2)
		local col = math.floor((vim.o.columns - width) / 2)

		local buf = vim.api.nvim_create_buf(false, true) -- Create a new unlisted buffer
		vim.api.nvim_open_win(buf, true, {
			relative = 'editor',
			row = row,
			col = col,
			width = width,
			height = height,
			style = 'minimal'
		})
		vim.fn.termopen(vim.o.shell)
		vim.api.nvim_command("startinsert")
	end
)
vim.keymap.set("n", "<leader>st",
	function()
		vim.cmd.vnew()
		vim.cmd.term()
		vim.cmd.wincmd("J")
		vim.api.nvim_win_set_height(0, 5)

		term_job_id = vim.bo.channel
	end
)

vim.keymap.set("n", "<leader>pre", function()
	if not term_job_id then return end
	vim.fn.chansend(term_job_id, { "pre-commit run --all-files\r\n" })
end)

-- Tabs --
vim.keymap.set("n", "<leader>tt", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, silent = true })

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
vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { noremap = true, silent = true })



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
