local vue_language_server_path =
'~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/'
return {
	setup = function(on_attach, capabilities)
		require("lspconfig").tsserver.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				plugins = {
					{
						name = '@vue/typescript-plugin',
						location = vue_language_server_path,
						languages = { 'vue' },
					},
				},
			},
			filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
		})
	end,
}
