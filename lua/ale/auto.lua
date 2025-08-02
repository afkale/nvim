-- Update ctags
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		vim.fn.system("ctags -a " .. vim.fn.expand("%"))
	end,
})

-- Terminal format
vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function(ev)
		local win = vim.fn.winbufnr(ev.buf)

		if vim.api.nvim_win_is_valid(win) then
			vim.wo[win].number = false
			vim.wo[win].relativenumber = false
		end
	end
})

-- Auto formatting files
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end

		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = args.buf,
				callback = function()
					if not vim.g.autoformat then return end

					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})
