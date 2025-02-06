vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	callback = function()
		local buf_type = vim.bo.buftype
		local buf_name = vim.api.nvim_buf_get_name(0)
		if buf_type == "terminal" and buf_name:match("lazygit") then
			vim.cmd("bdelete")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		vim.fn.system("ctags -a " .. vim.fn.expand("%"))
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "html", "javascript", "json", "typescript", "yaml", "typescriptreact" },
	command = "setlocal shiftwidth=2 tabstop=2",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua" },
	command = "setlocal shiftwidth=4 tabstop=4",
})

-- This is because i'm using ruff and pyright at the same time but I only want ruff
-- to handle the formatting
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})
