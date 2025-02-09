local Terminal = {
	BOT = "bot",
	FLOAT = "float"
}

local TerminalCMD = {
	FLOATERMINAL = "Floaterminal",
	BOTERMINAL = "Boterminal"
}

local state = {
	float = { win = -1, buf = -1, cmd = TerminalCMD.FLOATERMINAL },
	bot = { win = -1, buf = -1, cmd = TerminalCMD.BOTERMINAL }
}

--- Create a new buffer or reuse an existing one
local function create_buffer(buf)
	if buf and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end
	return vim.api.nvim_create_buf(false, true)
end

--- Create a floating window
local function create_floating_window(opts)
	opts = opts or {}

	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local win_config = {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded"
	}

	local buf = create_buffer(opts.buf)
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win, cmd = opts.cmd }
end

--- Create a bottom panel
local function create_bottom_panel(opts)
	opts = opts or {}

	vim.cmd("botright new") -- Create a new horizontal split at the bottom

	local win = vim.api.nvim_get_current_win()
	local buf = create_buffer(opts.buf)

	vim.api.nvim_win_set_buf(win, buf)
	vim.api.nvim_win_set_height(win, opts.height or 10) -- Default height

	return { buf = buf, win = win, cmd = opts.cmd }
end

--- Toggle a terminal window
local function toggle_terminal(mode)
	local terminal = state[mode]

	if not vim.api.nvim_win_is_valid(terminal.win) then
		-- Create the terminal window
		if mode == Terminal.FLOAT then
			state.float = create_floating_window(state.float)
		elseif mode == Terminal.BOT then
			state.bot = create_bottom_panel(state.bot)
		end

		terminal = state[mode] -- Update reference

		-- Open terminal if necessary
		if vim.bo[terminal.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end

		-- Set keymap for exiting terminal mode
		vim.api.nvim_buf_set_keymap(
			terminal.buf, "t", "<C-\\><C-\\>", "<C-\\><C-n><CMD>" .. terminal.cmd .. "<CR>",
			{ noremap = true, silent = true }
		)

		vim.cmd("startinsert")        -- Start insert mode
	else
		vim.api.nvim_win_hide(terminal.win) -- Hide the terminal if it's already open
	end
end

--- Create a terminal tab with a given command
local function create_command_tab(opts)
	opts = opts or {}

	-- Check if command exists
	if not opts.command or opts.command == "" then
		vim.notify("Error: Missing or empty 'command' argument.", vim.log.levels.ERROR)
		return
	end

	vim.cmd("tabnew")                       -- Create a new tab

	local buf = vim.api.nvim_get_current_buf() -- Get the buffer of the new tab

	-- Start command job and create a command to leave when it finish
	vim.fn.jobstart(opts.command, {
		term = true,
		on_exit = function()
			vim.api.nvim_buf_set_keymap(
				buf, "n", opts.close_key or "q", ":bdelete<CR>",
				{ noremap = true, silent = true }
			)
		end
	})
end

--- User commands
vim.api.nvim_create_user_command(TerminalCMD.FLOATERMINAL, function()
	toggle_terminal(Terminal.FLOAT)
end, { desc = "Run floating terminal." })

vim.api.nvim_create_user_command(TerminalCMD.BOTERMINAL, function()
	toggle_terminal(Terminal.BOT)
end, { desc = "Run bottom terminal." })

vim.api.nvim_create_user_command("Precommit", function()
	create_command_tab({ command = "pre-commit run --all-files", close_key = "q" })
end, { desc = "Run pre-commit hooks in a new tab" })
