local state = {
	float = {
		win = -1,
		buf = -1,
		cmd = "Floaterminal"
	},
	bot = {
		win = -1,
		buf = -1,
		cmd = "Boterminal"
	}
}

local function create_buffer(opts)
	opts = opts or {}
	if vim.api.nvim_buf_is_valid(opts.buf) then
		return opts.buf
	else
		return vim.api.nvim_create_buf(false, true)
	end
end

local function create_floating_window(opts)
	opts = opts or {}

	-- Get the window sizes
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
	local buf = create_buffer(opts)
	local win = vim.api.nvim_open_win(buf, true, win_config)
	return { buf = buf, win = win, cmd = opts.cmd }
end

local function create_bottom_panel(opts)
	opts = opts or {}

	local height = opts.height or 10 -- Default height for the bottom panel

	-- Create a new horizontal split at the bottom
	vim.cmd("botright new")

	-- Get the window and buffer of the new split
	local win = vim.api.nvim_get_current_win()
	local buf = create_buffer(opts)

	-- Set the buffer to window
	vim.api.nvim_win_set_buf(win, buf)

	-- Set the height of the bottom panel
	vim.api.nvim_win_set_height(win, height)

	return { buf = buf, win = win, cmd = opts.cmd }
end

-- Helper function to create a terminal tab with a given command
local function create_command_tab(opts)
	opts = opts or {}

	-- Ensure the 'command' option is provided
	if not opts.command or opts.command == "" then
		print("Error: Missing or empty 'command' argument.")
		return
	end

	-- Create a new tab
	vim.cmd("tabnew")

	-- Get the current buffer handle
	local buf = vim.api.nvim_get_current_buf()

	-- Start the job with the provided command
	vim.fn.jobstart(opts.command, {
		term = true,
		on_exit = function()
			-- Close the buffer with 'q' key mapping
			vim.api.nvim_buf_set_keymap(
				buf,
				"n",
				opts.close_key or "q",
				":bdelete<CR>",
				{ noremap = true, silent = true }
			)
		end
	})
end

-- Helper function to toggle a terminal window
local function toggle_terminal(mode)
	local terminal = state[mode]

	-- If the terminal window is invalid, create it
	if not vim.api.nvim_win_is_valid(terminal.win) then
		-- Create window based on mode
		if mode == "float" then
			state.float = create_floating_window(state.float)
		elseif mode == "bot" then
			state.bot = create_bottom_panel(state.bot)
		end

		terminal = state[mode] -- Reassign after creation
		-- Open terminal if necessary
		if vim.bo[terminal.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end

		-- Set keymap for exiting terminal mode
		vim.api.nvim_buf_set_keymap(
			terminal.buf, "t", "<C-\\><C-\\>", "<C-\\><C-n><CMD>" .. terminal.cmd .. "<CR>",
			{ noremap = true, silent = true }
		)

		-- Start insert mode when entering terminal
		vim.cmd("startinsert")
	else
		-- Hide the terminal if it's already open
		vim.api.nvim_win_hide(terminal.win)
	end
end

-- Create the user command for Floaterminal
vim.api.nvim_create_user_command(
	"Floaterminal", function() toggle_terminal("float") end, { desc = "Run floating terminal." }
)

-- Create the user command for Boterminal
vim.api.nvim_create_user_command(
	"Boterminal", function() toggle_terminal("bot") end, { desc = "Run bottom terminal." }
)

-- Create the Precommit command
vim.api.nvim_create_user_command("Precommit", function()
	create_command_tab({ command = "pre-commit run --all-files", close_key = "q" })
end, {
	desc = "Run pre-commit hooks in a new tab"
})
