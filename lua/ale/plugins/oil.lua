return {
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
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
					end
				end,
			})
		end
	}
}
