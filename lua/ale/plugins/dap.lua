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
						headers = {
							breakpoints = "Breakpoints [B]",
							scopes = "Scopes [S]",
							exceptions = "Exceptions [E]",
							watches = "Watches [W]",
							threads = "Threads [T]",
							repl = "REPL [R]",
							console = "Console [C]",
						},
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
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
			vim.keymap.set("n", "<leader>dc", dap.continue, opts)
			vim.keymap.set("n", "<leader>do", dap.step_over, opts)
			vim.keymap.set("n", "<leader>di", dap.step_into, opts)
			vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
			vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
			vim.keymap.set("n", "<leader>dd", view.toggle, opts)
			vim.keymap.set('n', '<Leader>dr', dap.repl.open, opts)
			vim.keymap.set('n', '<Leader>dl', dap.run_last, opts)

			vim.keymap.set({ 'n', 'v' }, '<Leader>dh', widgets.hover, opts)
			vim.keymap.set({ 'n', 'v' }, '<Leader>dp', widgets.preview, opts)
			vim.keymap.set('n', '<Leader>df', function()
				widgets.centered_float(widgets.frames)
			end, opts)
			vim.keymap.set('n', '<Leader>ds', function()
				widgets.centered_float(widgets.scopes)
			end, opts)
		end,
	},
}
