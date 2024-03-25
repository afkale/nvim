-- Note: If working with a repository where eslint is specified in the package.json
-- but the node_modules are not installed, install eslint globally: npm i -g eslint
local root_pattern = require("lspconfig.util").root_pattern
return {
	setup = function(on_attach, capabilities)
		require 'lspconfig'.clangd.setup({
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			cmd = { "clangd" },
			on_attach = on_attach,
			capabilities = capabilities,
			root_pattern(
				'.clangd',
				'.clang-tidy',
				'.clang-format',
				'compile_commands.json',
				'compile_flags.txt',
				'configure.ac',
				'.git'
			)

		})
	end,
}
