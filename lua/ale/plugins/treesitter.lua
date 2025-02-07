return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"csv",
				"dockerfile",
				"fish",
				"gitignore",
				"html",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"python",
				"query",
				"scss",
				"sql",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			refactor = {
				navigation = {
					enable = true,
					keymaps = {
						goto_definition = "gnd",
						list_definitions = "gnD",
						list_definitions_toc = "gO",
						goto_next_usage = "<a-*>",
						goto_previous_usage = "<a-#>",
					},
				},
				smart_rename = {
					enable = true,
					keymaps = {
						smart_rename = "grr",
					},
				},
			},
		})
	end,
}
