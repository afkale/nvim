return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("fzf-lua").setup({})
			local fzf = require("fzf-lua")

			vim.keymap.set('n', 'fg', fzf.live_grep, {})
			vim.keymap.set('n', 'fd', fzf.grep_curbuf, {})
			vim.keymap.set('n', 'ff', fzf.files, {})
			vim.keymap.set('n', 'fs', fzf.lsp_document_symbols, {})
			vim.keymap.set('n', 'fw', fzf.lsp_live_workspace_symbols, {})
			vim.keymap.set('n', 'fc', fzf.commands, {})
			vim.keymap.set({ 'n', 'v' }, 'fr', fzf.lsp_finder, {})
			vim.keymap.set('n', 'fm', fzf.buffers, {})
		end
	}
}
