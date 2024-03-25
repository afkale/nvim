return {
	setup = function(on_attach, capabilities)
		require("lspconfig").pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				pyright = {
					autoImportCompletion = true,
				},
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = 'openFilesOnly',
						useLibraryCodeForTypes = true,
						typeCheckingMode =
						'off'
					}
				}
			}
		})
	end,
}
