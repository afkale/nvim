return {
	{
		"afkale/terminale.nvim",
		config = function()
			local terminale = require "terminale"
			terminale.setup({

				test = {
					hidden = true,
					window_theme = require("terminale.theme").default_window_theme(),
					command = "test",
					user_command = "Top",
					on_create = function(window)
						vim.fn.termopen("top", { on_exit = function() window:close() end })
					end,
					modes = "insert",
					keymap = {
						{
							cmd = "<leader>gt",
							mode = { "n", "t" },
							key = "<CMD>Top<CR>",
						},
					},
				},

			})
		end
	}
}
