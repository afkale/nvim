return {
	{ "onsails/lspkind-nvim" },
	{
		"NvChad/nvim-colorizer.lua",
		opts = {},
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "kyazdani42/nvim-web-devicons" },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "folke/neodev.nvim" },
	{ "junegunn/fzf" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.looking-glass"] = {},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.keybinds"] = {
						config = {
							default_keybinds = true,
							neorg_leader = "gt",
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/.notes/main",
								preorder = "~/.notes/preorder",
								valoriza = "~/.notes/valoriza",
							},
						},
					},
				},
			})
		end,
	},
}
