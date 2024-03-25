return {
	{
		'rcarriga/nvim-notify',
		priority = 1000,
		config = function()
			vim.notify = require("notify")
		end,
	},
}
