return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "nvim-treesitter/nvim-treesitter-context" },
	config = function()
		local configs = require("nvim-treesitter.configs")

		local settings = {
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
		}
		configs.setup(settings)
		require("treesitter-context").setup({ enable = true })
	end,
}
