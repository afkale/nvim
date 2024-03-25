local cmp_status_ok, cmp = pcall(require, "cmp")
local lspkind_status_ok, lspkind = pcall(require, "lspkind")
-- local luasnip_status_ok, luasnip = pcall(require, "luasnip")

if not (cmp_status_ok and lspkind_status_ok) then
	vim.api.nvim_err_writeln("CMP dependencies not yet installed!")
	return
end


if cmp_status_ok then
	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end
		},
		formatting = {
			fields = { 'menu', 'abbr', 'kind' },
			expandable_indicator = true,
			format = lspkind.cmp_format({
				mode = 'symbol_text',
				maxwidth = 50,
				elipsis_char = '...',
				show_labelDetails = true,
			})
		},
		mapping = {
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
			["<S-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			["<S-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		},
		sources = cmp.config.sources({
			{ max_item_count = 10, name = "nvim_lsp", },
			{ max_item_count = 10, name = "nvim_lsp:volar", },
			{ max_item_count = 10, name = "luasnip", },
			{ max_item_count = 10, name = "nvim_lua", },
			{ max_item_count = 10, name = "path", },
			{ max_item_count = 10, name = "buffer", },
			{ max_item_count = 10, name = "nvim_lsp_signature_help", },
			--			{ name = "latex_symbols",           option = { strategy = 0, } }
		}),
	})
end
