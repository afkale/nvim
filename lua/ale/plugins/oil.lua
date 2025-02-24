return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
		config = function()
			local oil = require("oil")
			oil.setup({})

			vim.keymap.set("n", "<leader>e", ":Oil --preview<CR>",
				{ desc = "Open parent directory", noremap = true, silent = true })
		end
	}
}
