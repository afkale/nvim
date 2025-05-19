return {
	{
		"OXY2DEV/helpview.nvim", lazy = false
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
		config = function()
			require("quicker").setup()
		end
	}
}
