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

-- Auto formatting files
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then return end
		if client.supports_method("textDocument/formatting") then
			if not vim.g.autoformat then return end
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})
