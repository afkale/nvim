return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"igorlfs/nvim-dap-view",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local view = require("dap-view")
			local widgets = require("dap.ui.widgets")
			local dapPython = require("dap-python")

			view.setup(
				{
					winbar = {
						show = true,
						-- You can add a "console" section to merge the terminal with the other views
						sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
						-- Must be one of the sections declared above
						default_section = "watches",
					},
					windows = {
						height = 12,
						terminal = {
							-- 'left'|'right'|'above'|'below': Terminal position in layout
							position = "left",
							-- List of debug adapters for which the terminal should be ALWAYS hidden
							hide = {},
							-- Hide the terminal when starting a new session
							start_hidden = true,
						},
					},
					-- Controls how to jump when selecting a breakpoint or navigating the stack
					switchbuf = "usetab",
				}
			)

			dapPython.setup("python")

			-- Automatically open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				view.open()
			end

			local opts = { noremap = true, silent = true }

			-- Dap Keymaps
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
			vim.keymap.set("n", "<leader>dd", view.toggle, { desc = "Toggle dap view" })
			vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "" })
			vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = "Run last" })

			vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover, {})
			vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview, {})
			vim.keymap.set('n', '<Leader>df', function()
				widgets.centered_float(widgets.frames)
			end, {})
			vim.keymap.set('n', '<Leader>ds', function()
				widgets.centered_float(widgets.scopes)
			end, {})
		end,
	},
}
