return {
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "onsails/lspkind-nvim" },

	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-nvim-lua", ft = { "lua" } },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "saadparwaiz1/cmp_luasnip" },

	{
		"NvChad/nvim-colorizer.lua",
		opts = {},
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	{ "kyazdani42/nvim-web-devicons" },
	{ "folke/neodev.nvim" },
	{ "junegunn/fzf" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
}
