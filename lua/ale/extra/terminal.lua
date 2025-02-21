local utils = require("ale.extra.utils")

local Terminal = {
	BOT = "bot",
	FLOAT = "float"
}

local TerminalUserCMD = {
	FLOATERMINAL = "Floaterminal",
	BOTERMINAL = "Boterminal"
}

local state = {
	float = { win = -1, buf = -1, ucmd = TerminalUserCMD.FLOATERMINAL },
	bot = { win = -1, buf = -1, ucmd = TerminalUserCMD.BOTERMINAL }
}

--- Toggle a terminal window
local function toggle_terminal(mode)
	local terminal = state[mode]

	if not vim.api.nvim_win_is_valid(terminal.win) then
		-- Create the terminal window
		if mode == Terminal.FLOAT then
			state.float = utils.create_floating_window({ buf = state.float.buf })
		elseif mode == Terminal.BOT then
			state.bot = utils.create_split({
				place = "botright",
				option = "new",
				buf = state.bot.buf
			})
		end
		terminal = state[mode]

		-- Open terminal if necessary
		if vim.bo[terminal.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end

		vim.cmd("startinsert")            -- Start insert mode
	else
		vim.api.nvim_win_hide(terminal.win) -- Hide the terminal if it's already open
	end
end

local function create_disposable_command_tab(opts)
	opts = opts or {}

	-- Check if command exists
	if not opts.command or opts.command == "" then
		error("Error: Missing or empty 'command' argument.", vim.log.levels.ERROR)
	end

	-- Create a new tab and get its buffer

	-- Function to execute the command
	local function execute_command()
		-- Start command job and create a command to leave when it finishes
		vim.cmd("tabnew")
		local buf = vim.api.nvim_get_current_buf() -- Get the buffer of the new tab

		vim.fn.termopen(opts.command, {
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

--- User commands
vim.api.nvim_create_user_command(TerminalUserCMD.FLOATERMINAL, function()
	toggle_terminal(Terminal.FLOAT)
end, { desc = "Run floating terminal." })

vim.api.nvim_create_user_command(TerminalUserCMD.BOTERMINAL, function()
	toggle_terminal(Terminal.BOT)
end, { desc = "Run bottom terminal." })

vim.api.nvim_create_user_command("Precommit", function()
	create_disposable_command_tab({ command = "pre-commit run --all-files", close_key = "q" })
end, { desc = "Run pre-commit hooks in a new tab" })
