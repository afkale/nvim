vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	callback = function()
		local buf_type = vim.bo.buftype
		local term_title = vim.b.term_title or ""
		if buf_type == "terminal" and term_title:match("lazygit") then
			vim.cmd("tabclose")
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.bo.equalprg = "ruff format --quiet -"
	end,
})
