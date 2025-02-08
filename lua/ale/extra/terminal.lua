local state = {
	floating = {
		win = -1,
		buf = -1,
	},
	bottom = {
		win = -1,
		buf = -1,
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
	return { buf = buf, win = win }
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

	return { buf = buf, win = win }
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

-- Function to toggle the floating terminal
local function toggle_floaterminal()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		-- Create the terminal window based on the mode
		state.floating = create_floating_window(state.floating)

		-- Open a terminal if necessary
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		-- Hide the terminal window if it's already valid
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Function to toggle the bottom terminal
local function toggle_boterminal()
	if not vim.api.nvim_win_is_valid(state.bottom.win) then
		-- Create the terminal window based on the mode
		state.bottom = create_bottom_panel(state.bottom)

		-- Open a terminal if necessary
		if vim.bo[state.bottom.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		-- Hide the terminal window if it's already valid
		vim.api.nvim_win_hide(state.bottom.win)
	end
end

-- Create the user command for Floaterminal
vim.api.nvim_create_user_command("Floaterminal", toggle_floaterminal, { desc = "Run floating terminal." })

-- Create the user command for Boterminal
vim.api.nvim_create_user_command("Boterminal", toggle_boterminal, { desc = "Run bottom terminal." })

-- Create the Precommit command
vim.api.nvim_create_user_command("Precommit", function()
	create_command_tab({ command = "pre-commit run --all-files", close_key = "q" })
end, {
	desc = "Run pre-commit hooks in a new tab"
})
