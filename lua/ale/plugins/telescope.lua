return {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP Document Symbols" },
		{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "LSP Dynamic Workspace Symbols" },
		{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
		{ "<leader>fG", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
		{ "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo Tree" },
		{ "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume Last" },
		{ "<leader>fi", "<cmd>Telescope import<cr>", desc = "Import" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-symbols.nvim",
		"debugloop/telescope-undo.nvim",
		"piersolenski/telescope-import.nvim",
		"crispgm/telescope-heading.nvim",
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "▎ ",
				multi_icon = " │ ",
				layout_strategy = "flex",
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-p>"] = actions.preview_scrolling_down,
						["<C-n>"] = actions.preview_scrolling_up,
					},
					n = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-p>"] = actions.preview_scrolling_down,
						["<C-n>"] = actions.preview_scrolling_up,
					},
				},
				file_ignore_patterns = {
					"node_modules",
				},
			},
			pickers = {
				buffers = {
					previewer = false,
					theme = "dropdown",
					mappings = {
						n = {
							["<C-e>"] = "delete_buffer",
							["l"] = "select_default",
						},
					},
					initial_mode = "normal",
				},
				find_files = {
					layout_strategy = "vertical",
					-- layout_config = { height = 0.9 },
					-- previewer = false,
					layout_config = {
						prompt_position = "top",
						preview_width = 0.5,
						-- width = 0.7,
					},
					sorting_strategy = "ascending",
				},
				help_tags = {
					theme = "ivy",
				},
				symbols = {
					theme = "dropdown",
				},
				registers = {
					theme = "ivy",
				},
				grep_string = {
					initial_mode = "normal",
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
			},
			extensions = {
				undo = {
					initial_mode = "normal",
					use_delta = true,
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
				},
				heading = {
					treesitter = true,
				},
			},
		})

		-- Extensions
		require("telescope").load_extension("undo")
		require("telescope").load_extension("import")
		require("telescope").load_extension("heading")
	end,
}
