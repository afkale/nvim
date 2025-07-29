local u = require("ale.extra.utils")
local kmopts = { noremap = true, silent = true }

-- LSP Keymaps
u.kmset("n", "gri", vim.lsp.buf.references, kmopts)
u.kmset("n", "grn", vim.lsp.buf.rename, kmopts)
u.kmset("n", "gra", vim.lsp.buf.code_action, kmopts)
u.kmset("n", "gft", function()
	vim.g.autoformat = not vim.g.autoformat
	vim.notify(vim.g.autoformat and 'Formatting Active' or 'Formatting Disabled', vim.log.levels.INFO)
end)
u.kmset("n", "gff", vim.lsp.buf.format, kmopts)
u.kmset("n", "ge", vim.diagnostic.setqflist, kmopts)
u.kmset("n", "gd", vim.lsp.buf.definition, kmopts)
u.kmset("n", "gD", vim.lsp.buf.declaration, kmopts)
u.kmset("n", "gi", vim.lsp.buf.implementation, kmopts)
u.kmset("n", "fs", vim.lsp.buf.workspace_symbol, kmopts)
u.kmset("n", "K", function() vim.lsp.buf.hover { border = "single" } end, kmopts)
u.kmset("n", "E", function() vim.diagnostic.open_float { border = "single" } end, kmopts)

-- DAP Keymaps
local isDapLoaded, dap = pcall(require, "dap")
local isDapViewLoaded, dapView = pcall(require, "dap-view")
local isDapUiLoaded, dapUiWidgets = pcall(require, "dap.ui.widgets")

if isDapLoaded then
	u.kmset("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
	u.kmset("n", "<leader>dc", dap.continue, { desc = "Continue" })
	u.kmset("n", "<leader>do", dap.step_over, { desc = "Step over" })
	u.kmset("n", "<leader>di", dap.step_into, { desc = "Step into" })
	u.kmset("n", "<leader>dO", dap.step_out, { desc = "Step out" })
	u.kmset("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
	u.kmset('n', '<leader>dr', dap.repl.open, { desc = "" })
	u.kmset('n', '<leader>dl', dap.run_last, { desc = "Run last" })
end
if isDapViewLoaded then
	u.kmset("n", "<leader>dd", dapView.toggle, { desc = "Toggle dap view" })
end
if isDapUiLoaded then
	u.kmset({ 'n', 'v' }, '<leader>dh', dapUiWidgets.hover, {})
	u.kmset({ 'n', 'v' }, '<leader>dp', dapUiWidgets.preview, {})
	u.kmset('n', '<leader>df', function() dapUiWidgets.centered_float(dapUiWidgets.frames) end, {})
	u.kmset('n', '<leader>ds', function() dapUiWidgets.centered_float(dapUiWidgets.scopes) end, {})
end

-- FZF Keymaps
if vim.g.loaded_fzf_vim then
	u.kmset("n", "<leader><space>", ":GFiles<CR>", { noremap = true, silent = true })
	u.kmset("n", "<leader>ff", ":Files<CR>", { noremap = true, silent = true })
	u.kmset("n", "<leader>fj", ":Jumps<CR>", { noremap = true, silent = true })
	u.kmset("n", "<leader>fg", ":Rg<CR>", { noremap = true, silent = true })
	u.kmset("n", "<leader>fc", ":Ag<CR>", { noremap = true, silent = true })
	u.kmset("n", "<leader>fb", ":Lines<CR>", { noremap = true, silent = true })
end

-- OIL Keymaps
local isOilLoaded, oil = pcall(require, "oil")
if isOilLoaded then
	local oilToggle = function()
		if vim.bo.filetype ~= "oil" then
			oil.open_float(nil,
				{ preview = { horizontal = true, vertical = false, split = "topleft" } }
			)
		else
			oil.close()
		end
	end

	vim.api.nvim_create_user_command("OilToggle", oilToggle, { desc = "Toggle Oil" })
	u.kmset("n", "<leader>e", oilToggle, { desc = "Toggle Oil", noremap = true, silent = true })
end

-- HARPOON Keymaps
local isHarpoonLoaded, _ = pcall(require, "harpoon")
if isHarpoonLoaded then
	u.kmset('n', '<leader>ma', ':lua require("harpoon.mark").add_file()<CR>', kmopts)
	u.kmset('n', '<leader>mm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', kmopts)
	u.kmset('n', '<leader>mp', ':lua require("harpoon.ui").nav_prev()<CR>', kmopts)
	u.kmset('n', '<leader>mn', ':lua require("harpoon.ui").nav_next()<CR>', kmopts)
	u.kmset('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', kmopts)
	u.kmset('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', kmopts)
	u.kmset('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', kmopts)
	u.kmset('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', kmopts)
	u.kmset('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<CR>', kmopts)
	u.kmset('n', '<leader>6', ':lua require("harpoon.ui").nav_file(6)<CR>', kmopts)
	u.kmset('n', '<leader>7', ':lua require("harpoon.ui").nav_file(7)<CR>', kmopts)
	u.kmset('n', '<leader>8', ':lua require("harpoon.ui").nav_file(8)<CR>', kmopts)
	u.kmset('n', '<leader>9', ':lua require("harpoon.ui").nav_file(9)<CR>', kmopts)
end


-- QUICKER Keymaps
local isQuickerLoaded, quicker = pcall(require, "quicker")
if isQuickerLoaded then
	vim.keymap.set("n", "<leader>cc", quicker.toggle, { desc = "Toggle quickfix" })
end
