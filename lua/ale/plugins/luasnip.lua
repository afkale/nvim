return {
	"L3MON4D3/LuaSnip",
	lazy = true,
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = { "rafamadriz/friendly-snippets", lazy = true },
	config = function()
		require("luasnip.loaders.from_vscode").load()
	end

}
