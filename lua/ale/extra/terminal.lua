require("ale.extra.utils")
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
			state.float = create_floating_window({ buf = state.float.buf })
		elseif mode == Terminal.BOT then
			state.bot = create_split({
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

		vim.cmd("startinsert")        -- Start insert mode
	else
		vim.api.nvim_win_hide(terminal.win) -- Hide the terminal if it's already open
	end
end

local function floating_lazygit()
	local window = create_floating_window({})
	vim.fn.termopen("lazygit", {
		on_exit = function()
			vim.api.nvim_win_close(window.win, true)
			vim.api.nvim_buf_delete(window.buf, {})
		end,
	})
	vim.cmd("startinsert")
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

vim.api.nvim_create_user_command(
	"Lazygit", floating_lazygit, { desc = "Run floating lazygit command." }
)

local fzf_command = "fzf --preview 'bat --color=always --style=plain --theme=Catppuccin\\ Mocha {}'"
local function select_file()
	local old_buf = vim.api.nvim_get_current_buf()
	local window = create_floating_window({})

	vim.cmd("startinsert")

	local tmp = vim.fn.tempname()
	vim.fn.termopen(fzf_command .. " > " .. tmp, {
		on_exit = function()
			local fname = vim.fn.readfile(tmp)[1]

			-- Close this term buffer and window
			vim.api.nvim_win_close(window.win, true)
			vim.api.nvim_buf_delete(window.buf, {})

			-- Get the old buffer
			vim.api.nvim_set_current_buf(old_buf)

			if vim.fn.filereadable(fname) == 1 then
				vim.cmd('edit ' .. vim.fn.fnameescape(fname))
			end

			vim.fn.delete(tmp)
		end
	})
end

-- Create a command for easy execution
vim.api.nvim_create_user_command('Fzf', select_file, {})
vim.keymap.set("n", "<leader>ff", ":Fzf<CR>")
