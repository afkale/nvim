return {
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"echasnovski/mini.files",
		config = function()
			require('mini.files').setup()
		end
	},
}
