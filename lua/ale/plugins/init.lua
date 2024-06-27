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
}
