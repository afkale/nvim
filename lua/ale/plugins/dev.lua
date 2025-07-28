return {
	{
		"afkale/terminale.nvim",
		config = function()
			local terminale = require "terminale"

			local width = math.floor(vim.o.columns * 0.9)
			local height = math.floor(vim.o.lines * 0.25)
			local col = math.floor((vim.o.columns - width) / 2)
			local row = vim.o.lines - height - 4

			terminale.setup({
				boterm = {
					hidden = true,
					window_theme = {
						win_config = {
							title = "Terminale",
							width = width,
							height = height,
							row = row,
							col = col,
							relative = "editor",
							style = "minimal",
							border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
						}
					},
					user_command = "Boterm",
					on_create = function(window)
						vim.fn.jobstart("fish -i", {
							term = true,
							on_exit = function(_, exit_code) window:close() end,
						})
					end,
					on_enter = function() vim.cmd("startinsert") end,
					keymap = {
						{
							cmd = "<A-2>",
							mode = { "n", "t" },
							key = "<CMD>Boterm<CR>",
						},
					},
				},
			})
		end
	}
}
