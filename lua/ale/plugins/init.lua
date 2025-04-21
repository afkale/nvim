return {
	{
		"OXY2DEV/helpview.nvim",
		lazy = false
	},
	{
		'stevearc/overseer.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('overseer').setup()
		end
	}
}
