local u = require("ale.extra.utils")

return {
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		config = function()
			u.kmset("n", "<leader><space>", ":GFiles<CR>", { noremap = true, silent = true })
			u.kmset("n", "<leader>ff", ":Files<CR>", { noremap = true, silent = true })
			u.kmset("n", "<leader>fj", ":Jumps<CR>", { noremap = true, silent = true })
			u.kmset("n", "<leader>fg", ":Rg<CR>", { noremap = true, silent = true })
			u.kmset("n", "<leader>fc", ":Ag<CR>", { noremap = true, silent = true })
			u.kmset("n", "<leader>fb", ":Lines<CR>", { noremap = true, silent = true })
		end
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
		config = function()
			local oil = require("oil")
			oil.setup()

			local toggle_float = function()
				if vim.bo.filetype ~= "oil" then
					oil.open_float(nil,
						{ preview = { horizontal = true, vertical = false, split = "topleft" } }
					)
				else
					oil.close()
				end
			end

			vim.keymap.set("n", "<leader>e", toggle_float,
				{ desc = "Open directory", noremap = true, silent = true }
			)
		end
	}
}
