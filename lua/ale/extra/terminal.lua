local function create_disposable_command_tab(opts)
	opts = opts or {}

	-- Check if command exists
	if not opts.command or opts.command == "" then
		error("Error: Missing or empty 'command' argument.", vim.log.levels.ERROR)
	end

	-- Function to execute the command
	local function execute_command()
		-- Start command job and create a command to leave when it finishes
		vim.cmd("tabnew")
		local buf = vim.api.nvim_get_current_buf() -- Get the buffer of the new tab

		vim.fn.jobstart(opts.command, {
			term = true,
			on_exit = function()
				-- Set a keymap to close the buffer when the job exits
				vim.api.nvim_buf_set_keymap(
					buf, "n", opts.close_key or "q", ":bdelete!<CR>",
					{ noremap = true, silent = true }
				)

				-- Create a user command to retry the command
				vim.api.nvim_buf_create_user_command(buf, "Retry", function()
					vim.cmd(":bdelete!")
					execute_command()
				end, {})

				-- Set a keymap to retry the command
				vim.api.nvim_buf_set_keymap(
					buf, "n", "<C-r>", "<CMD>Retry<CR>",
					{ noremap = true, silent = true }
				)
			end
		})
	end

	-- Execute the command initially
	execute_command()
end

vim.api.nvim_create_user_command("Precommit", function()
	create_disposable_command_tab({ command = "pre-commit run --all-files", close_key = "q" })
end, { desc = "Run pre-commit hooks in a new tab" })

-- keymaps
vim.keymap.set("n", "<leader>pre", ":Precommit<CR>", { noremap = true, silent = true })
