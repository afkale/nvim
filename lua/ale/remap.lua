local utils = require("ale.functions.utils")

vim.g.mapleader = " "

vim.keymap.set({ "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_d')

vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader><leader>", ":source<cr>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "tw", vim.cmd.tabnew)
vim.keymap.set("n", "tn", vim.cmd.tabnext)
vim.keymap.set("n", "tp", vim.cmd.tabprev)
vim.keymap.set("n", "tc", vim.cmd.tabclose)

vim.keymap.set("n", "sv", vim.cmd.vsplit)
vim.keymap.set("n", "sh", vim.cmd.split)
vim.keymap.set("n", "sc", vim.cmd.close)

vim.keymap.set("n", "mp", vim.cmd.bp)
vim.keymap.set("n", "mn", vim.cmd.bn)
vim.keymap.set("n", "mc", vim.cmd.bd)
vim.keymap.set("n", "mf", vim.lsp.buf.format)

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("n", "zz", "<cmd>write<cr>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

function SurroundSelectionWithPair(char)
	-- TODO: Handle V mode
	if vim.fn.visualmode() ~= "v" then
		return
	end

	-- FIX: When selection goes to the end it takes a super big e_row
	local c_buf, s_row, s_col, e_row, e_col = utils.get_visual_selection_indices()
	local text = vim.api.nvim_buf_get_text(c_buf, s_row, s_col, e_row, e_col + 1, {})

	local s_char, e_char = utils.get_couple(char)

	text[1] = s_char .. text[1]
	text[#text] = text[#text] .. e_char

	vim.api.nvim_buf_set_text(c_buf, s_row, s_col, e_row, e_col + 1, text)
	return text
end

for key, _ in pairs(utils.couples) do
	local command = string.format(':lua SurroundSelectionWithPair("%s")<CR>', key)
	vim.keymap.set("v", key, command, { noremap = true, silent = true })
end

vim.keymap.set({ "v", "n" }, "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set({ "v", "n" }, "<S-Tab>", "<<", { noremap = true, silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- LSP CMDS
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
vim.keymap.set("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
vim.keymap.set("n", "<leader>ff", "<cmd>Format<CR>", opts)
