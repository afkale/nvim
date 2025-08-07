return {
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		config = function()
			vim.g.fzf_layout = { window = { width = 0.9, height = 0.9, border = "sharp" } }
		end
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
	}
}
